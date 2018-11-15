local this = {}
this.id = Isaac.GetTrinketIdByName("Dark Lock")

function this:trigger(pickup, col)
  local player = Isaac.GetPlayer(0)
  if col:ToPlayer() ~= nil and player:HasTrinket(this.id) then
    local data = pickup:GetData()

    if pickup.Variant == PickupVariant.PICKUP_REDCHEST and data.darkLocked == nil and pickup.SubType == ChestSubType.CHEST_OPENED then
      data.darkLocked = true

      print("triggering dark lock effect")
      -- Good effects --
      if utils.chancep(50) then
        -- Drop random amount of coins, bombs or keys --
        if utils.chancep(75) then
          for i = 0, math.random(0, 2), 1 do
            local reward = utils.choose(
            { txt = 'coin', var = PickupVariant.PICKUP_COIN },
            { txt = 'bomb', var = PickupVariant.PICKUP_BOMB },
            { txt = 'key', var = PickupVariant.PICKUP_KEY }, nil, nil)

            if reward.txt ~= nil then
              Isaac.Spawn(EntityType.ENTITY_PICKUP, reward.var, 0, pickup.Position, Vector.FromAngle(math.random(0, 360)), nil)
            end
          end
        end

        -- Spawn friendly spiders or/and with 25% chance --
        if utils.chancep(25) then
          for i = 0, math.random(0, 2), 1 do
            Isaac.Spawn(3, 73, 0, pickup.Position, Vector.FromAngle(math.random(0, 360)), nil)
          end

          if utils.chancep(25) then
            for i = 0, math.random(0, 2), 1 do
              Isaac.Spawn(3, 43, 0, pickup.Position, Vector.FromAngle(math.random(0, 360)), nil)
            end
          end
        end

        -- Drop a trinket with 10% chance --
        if utils.chancep(10) then
          Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 0, pickup.Position, Vector.FromAngle(math.random(0, 360)), nil)
        end

      -- Bad effects --
      else
        -- Expode with 5% chance --
        if utils.chancep(5) then
          pickup:Kill()
          Isaac.Explode(pickup.Position, pickup, 1.0)

        -- Spawn many troll bombs with 5% chance --
        elseif utils.chancep(5) then
          for i = 0, math.random(2, 8), 1 do
            Isaac.Spawn(4, 3, 0, pickup.Position, Vector.FromAngle(math.random(0, 360)) * math.random(1, 10), nil)
          end

        -- Spawn many spiders with 10% chance --
        elseif utils.chancep(10) then
          for i = 0, math.random(2, 8), 1 do
            Isaac.Spawn(85, 0, 0, pickup.Position, Vector.FromAngle(math.random(0, 360)) * math.random(1, 10), nil)
          end

        end
      end
    end
  end
end

function this.Init()
  mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, this.trigger)
end

return this
