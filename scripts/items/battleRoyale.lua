local this = {}
this.id = Isaac.GetItemIdByName("Battle Royale")

function this.use()
  SFXManager():Play(SoundEffect.SOUND_POWERUP1, 0.7, 0, false, 0.9)
  for e, entity in pairs(Isaac.GetRoomEntities()) do 
     if entity:IsActiveEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) and not entity:IsBoss() then 
        local clone = Game():Spawn(entity.Type, entity.Variant, entity.Position, Vector(0,0), entity, 0, 1):ToNPC()
--      clone.HitPoints = entity.HitPoints/1.25
        clone:SetSize(9, Vector(1,1), 12)
        clone.Scale = 0.75
	clone:AddCharmed(-1)
	clone:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
        clone:SetColor(Color(10,10,10,0.75,0,0,0),0,0,false,false)
        clone:GetData().battleRoyaled = true
     end 
  end
  return true
end

function this:update(clone)
    local data = clone:GetData()
    local chanse = clone.HitPoints*60 + math.random(-5,5)
    if data.battleRoyaled then
       if data.time == nil then data.time = math.random(-10,0) end
       if data.time <= chanse then data.time = data.time + 1 
       else
           Isaac.Spawn(1000, 19, 0, Vector(clone.Position.X, clone.Position.Y-4), Vector(0, 0), nil)
           SFXManager():Play(SoundEffect.SOUND_1UP, 0.5, 0, false, math.random(8, 12) / 10)
           clone:Remove()
       end
    end
end

function this:updateRoom()
  for e, entity in pairs(Isaac.GetRoomEntities()) do 
     if entity:GetData().battleRoyaled then
        entity:Remove()
     end
  end
end

function this.Init()
  mod:AddCallback(ModCallbacks.MC_USE_ITEM, this.use, this.id)
  mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, this.update)
  mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, this.updateRoom)
end

return this