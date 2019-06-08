local this = {}
this.id = Isaac.GetItemIdByName("Gasoline")
this.variant = Isaac.GetEntityVariantByName("Gasoline Fire")
this.descriptiont = "Lights up damaging fires when enemies die"

function this:cache(player, flag)
  local player = Isaac.GetPlayer(0)
  if player:HasCollectible(this.id) then
    --if not deliveranceData.temporary.hasGasoline then
      --deliveranceData.temporary.hasGasoline = true
      --deliveranceDataHandler.directSave()
      if flag == CacheFlag.CACHE_TEARCOLOR then
      player:AddNullCostume(deliveranceContent.costumes.gasoline)
      if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then  
        player:ReplaceCostumeSprite(Isaac.GetItemConfig():GetNullItem(deliveranceContent.costumes.gasoline), "gfx/characters/costumes_forgotten/sheet_costume_gasoline_forgotten.png", 0)
      end
      end
    --end
  end
end

function this:onHitNPC(npc)
  local player = Isaac.GetPlayer(0)
  if not npc:IsBoss() then 
    if player:HasCollectible(this.id) then
      local creep = Isaac.Spawn(1000, 45, 0, npc.Position, vectorZero, nil)
      creep.SpriteScale = Vector(math.min(1.75, 0.5+npc.MaxHitPoints / 50), math.min(1.75, 0.5+npc.MaxHitPoints / 50))
      creep:Update()
      sfx:Play(43, 0.8, 0, false, 1.2)
      local fire = Isaac.Spawn(1000, this.variant, 0, npc.Position, vectorZero, player)
      local data = fire:GetData()
      data.time = 0
      fire:GetSprite():Play("Start")
      fire.SpriteScale = Vector(math.min(1.75, 0.5+npc.MaxHitPoints / 50), math.min(0.6+npc.MaxHitPoints / 50))

      data.radius = npc.MaxHitPoints
      data.dmg = npc.MaxHitPoints / 20
      data.outTime = npc.MaxHitPoints * 10
    end
  end
end

function this:updateFire(npc)
  if npc.Variant == this.variant then
    local player = Isaac.GetPlayer(0)
    local data = npc:GetData()
    local sprite = npc:GetSprite()

    data.time = data.time + 1

    if sprite:IsFinished("Start") then sprite:Play("Loop") end

    if data and data.time >= data.outTime then sprite:Play("End") end

    if sprite:IsFinished("End") then npc:Remove() end

    for e, enemies in pairs(Isaac.FindInRadius(npc.Position, data.radius, EntityPartition.ENEMY)) do
      enemies:TakeDamage(data.dmg, 0, EntityRef(nil), 0)
    end
  end
end

function this.Init()
  mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, this.cache)
    
    
  mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH , this.onHitNPC)
  mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, this.updateFire)
end

return this
