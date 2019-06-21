local this = {}
this.costume = Isaac.GetCostumeIdByPath("gfx/characters/costumes/character_awan.anm2")
this.playerAwan = Isaac.GetPlayerTypeByName("Awan")

this.gunPowder = Isaac.GetTrinketIdByName("Gunpowder")
this.paper = Isaac.GetTrinketIdByName("Piece of Paper")
this.blood = Isaac.GetTrinketIdByName("Bottled Blood")
this.rib = Isaac.GetTrinketIdByName("Wooden Rib")
this.feather = Isaac.GetTrinketIdByName("Glowing Feather")

this.materials = {}

this.speedBonus = 0
this.currentSlot = 1
this.currentMaterial = this.gunPowder
this.currentMaterialNumber = 0

function this.checkForCauldron()
  local count = 0
  for _, e in pairs(Isaac.GetRoomEntities()) do
    if e.Type == Isaac.GetEntityTypeByName("Cauldron") and e.Variant == Isaac.GetEntityVariantByName("Cauldron") then count = count + 1 end
  end

  return count
end

function this:Update()
   local game = Game()
   local player = Isaac.GetPlayer(0)
   local level = game:GetLevel()
   local stage = level:GetStage()
   local room = game:GetRoom()

   if player:GetPlayerType() == this.playerAwan then 
    if not player:IsDead() then
   
      if deliveranceData.temporary.awanStartUp == nil then
        deliveranceData.temporary.hasMaterial = deliveranceData.temporary.hasMaterial or {}
         for i=1, 5 do 
            table.insert(deliveranceData.temporary.hasMaterial, 0)
         end
         table.insert(this.materials, this.gunPowder)
         table.insert(this.materials, this.paper)
         table.insert(this.materials, this.blood)
         table.insert(this.materials, this.rib)
         table.insert(this.materials, this.feather)
         deliveranceData.temporary.awanStartUp=true
         deliveranceDataHandler.directSave() 
      end

      for i=1, 5 do 
        if player:GetTrinket(0)==this.materials[i] then deliveranceData.temporary.hasMaterial[i]=deliveranceData.temporary.hasMaterial[i]+1 deliveranceDataHandler.directSave() player:TryRemoveTrinket(player:GetTrinket(0)) end
        if this.currentSlot == i then this.currentMaterial = this.materials[i] this.currentMaterialNumber=deliveranceData.temporary.hasMaterial[i] end
      end

      if level:GetAbsoluteStage() == 1 and level.EnterDoor == -1 and player.FrameCount == 1 then
         this.speedBonus = 0
         player:AddCacheFlags(CacheFlag.CACHE_SPEED)
         player:EvaluateItems()
         --player:AddCard(Card.CARD_DICE_SHARD)
      end
      if room:GetFrameCount() == 1 then
	    player:AddNullCostume(this.costume)
      end
      for e, collect in pairs(Isaac.GetRoomEntities()) do 
         if collect.Type == 5 then 
            if collect.Variant == 100 and this.checkForCauldron()==0 and collect.SubType ~= CollectibleType.COLLECTIBLE_POLAROID and collect.SubType ~= CollectibleType.COLLECTIBLE_NEGATIVE and collect.SubType ~= CollectibleType.COLLECTIBLE_KEY_PIECE_1 and collect.SubType ~= CollectibleType.COLLECTIBLE_KEY_PIECE_2 then
               Isaac.Spawn(1000, 15, 0, collect.Position, vectorZero, npc)
               sfx:Play(SoundEffect.SOUND_POWERUP1, 1, 0, false, 0.8)
               local loot = Utils.choose(this.blood, this.rib, this.paper, this.gunPowder, this.feather)
               local amount = 1

               if room:GetType() == RoomType.ROOM_DEVIL then       loot = Utils.choose(this.blood, this.rib) amount=Utils.choose(1,2)
               elseif room:GetType() == RoomType.ROOM_SHOP then    loot = Utils.choose(this.paper, this.gunPowder)
               elseif room:GetType() == RoomType.ROOM_CURSE then   loot = this.blood
               elseif room:GetType() == RoomType.ROOM_SECRET or room:GetType() == RoomType.ROOM_SUPERSECRET then loot = this.rib
               elseif room:GetType() == RoomType.ROOM_LIBRARY then loot = this.paper
               elseif room:GetType() == RoomType.ROOM_ANGEL then   loot = this.feather amount=Utils.choose(1,2)
               elseif room:GetType() == RoomType.ROOM_TREASURE then
                   if stage == LevelStage.STAGE1_1 or stage == LevelStage.STAGE1_2 or (stage == LevelStage.STAGE1_GREED and (game.Difficulty==2 or game.Difficulty==3)) then
                       amount=Utils.choose(2,3)
                   elseif stage == LevelStage.STAGE2_1 or stage == LevelStage.STAGE2_2 or (stage == LevelStage.STAGE2_GREED and (game.Difficulty==2 or game.Difficulty==3)) then
                       amount=2
                   else
                       amount=1
                   end
               elseif room:GetType() == RoomType.ROOM_BOSS then
                   if stage == LevelStage.STAGE1_1 or stage == LevelStage.STAGE1_2 or (stage == LevelStage.STAGE1_GREED and (game.Difficulty==2 or game.Difficulty==3)) then
                       amount=Utils.choose(2,3)
                   elseif stage == LevelStage.STAGE2_1 or stage == LevelStage.STAGE2_2 or (stage == LevelStage.STAGE2_GREED and (game.Difficulty==2 or game.Difficulty==3)) then
                       amount=2
                   else
                       amount=1
                   end
               end

               for i=1, amount do Isaac.Spawn(5, 350, loot, collect.Position, Vector.FromAngle(math.random(0, 360)):Resized(1), npc) end

               collect:Remove()
            end
            if collect.Variant == 350 and collect.SubType~=this.gunPowder and collect.SubType~=this.paper and collect.SubType~=this.blood and collect.SubType~=this.rib and collect.SubType~=this.feather then
               Isaac.Spawn(5, 350, Utils.choose(this.blood, this.rib, this.paper, this.gunPowder, this.feather), collect.Position, vectorZero, npc)
               collect:Remove()
            end 
         end 
      end

      if utils.switchData('cauldronSpawned') then
         local pos = Isaac.GetFreeNearPosition(room:GetCenterPos() - Vector(100, 80), 1)
         Isaac.Spawn(1000, 15, 0, pos, vectorZero, npc)
         Isaac.Spawn(Isaac.GetEntityTypeByName("Cauldron"), Isaac.GetEntityVariantByName("Cauldron"), 0, pos, vectorZero, player)
      end

      if room:IsClear() then this.speedBonus=1.85 else this.speedBonus=1 end
      player:AddCacheFlags(CacheFlag.CACHE_SPEED)
      player:EvaluateItems()
    end
   else
      for e, collect in pairs(Isaac.GetRoomEntities()) do 
         if collect.Type == 5 and collect.Variant == 350 and (collect.SubType==this.gunPowder or collect.SubType==this.paper or collect.SubType==this.blood or collect.SubType==this.rib or collect.SubType==this.feather) then
            Isaac.Spawn(5, 350, 0, collect.Position, vectorZero, player)
            collect:Remove()
         end 
      end
   end
end

function this:nullCauldronSpawn()   
   if deliveranceData.temporary.cauldronSpawned~=nil then
      deliveranceData.temporary.cauldronSpawned=false
      deliveranceDataHandler.directSave()
   end
end

function this:PostInit(player)
   if player:GetPlayerType() == this.playerAwan then
	--player:TryRemoveNullCostume(this.justHeadCostume)
	player:AddNullCostume(this.costume)
	costumeEquipped = true
   else
	player:TryRemoveNullCostume(this.costume)
	--player:TryRemoveNullCostume(this.justHeadCostume)
	costumeEquipped = false
  end
end

function this:EvaluateCache(player, cacheFlag)
  if player:GetPlayerType() == this.playerAwan then 
     if cacheFlag == CacheFlag.CACHE_SPEED then
	player.MoveSpeed = player.MoveSpeed * this.speedBonus
     --elseif cacheFlag == CacheFlag.CACHE_DAMAGE then
     --player.Damage = player.Damage - 0.17
     --elseif cacheFlag == CacheFlag.CACHE_FIREDELAY then 
     --   player.MaxFireDelay = player.MaxFireDelay - 1
     end
  end
end

local HudMaterials = Sprite() HudMaterials:Load("gfx/ui/hudMaterials.anm2", true)
local HudNumbers = Sprite() HudNumbers:Load("gfx/ui/hudNumbers.anm2", true)
local HudChoose = Sprite() HudChoose:Load("gfx/ui/hudChooseMaterial.anm2", true)
   
function RenderNumber(n, Position)
   if n==nil then n=0 end
   HudNumbers:SetFrame("Idle", math.floor(n/10))
   HudNumbers:RenderLayer(0,Position)
   HudNumbers:SetFrame("Idle", n % 10)
   HudNumbers:RenderLayer(0,Position+Vector(6,0))
end

function this:onRender()
   local player = Isaac.GetPlayer(0)
   if player:GetPlayerType() == this.playerAwan and deliveranceData.temporary.awanStartUp then 
      for i=1, 5 do 
        HudMaterials:SetFrame("Idle", i-1)
        HudMaterials:RenderLayer(0, Vector(i*16,222))
        RenderNumber(deliveranceData.temporary.hasMaterial[i], Vector(2+i*16,244))
      end
      HudChoose:Play("Idle", false)
      HudChoose:RenderLayer(0, Vector(8+this.currentSlot*16,238))
      HudChoose:Update()
      if not game:IsPaused() and Input.IsActionTriggered(ButtonAction.ACTION_DROP, 0) then
         if this.currentSlot<5 then
            this.currentSlot=this.currentSlot+1
         else
            this.currentSlot=1
         end
      end
   end
end

function this.Init()
  mod:AddCallback( ModCallbacks.MC_POST_UPDATE, this.Update)
  mod:AddCallback( ModCallbacks.MC_POST_PLAYER_INIT, this.PostInit)
  mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, this.EvaluateCache)
  mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, this.nullCauldronSpawn)
  mod:AddCallback(ModCallbacks.MC_POST_RENDER, this.onRender)
end

return this