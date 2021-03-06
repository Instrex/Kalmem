local this = {
    id = Isaac.GetTrinketIdByName("Extinguisher"),
    description = "Extinguishes nearby fireplaces",
    rusdescription ={"Extinguisher /������������", "����� ��������� ������"}
}

function this:update(player)
    if player:HasTrinket(this.id) then 
        for e, entity in pairs(Isaac.FindInRadius(player.Position, 22.0, EntityPartition.ENEMY)) do
            if entity.Type == EntityType.ENTITY_FIREPLACE then
                if entity.Variant == 2 or entity.Variant == 3 then
                    Isaac.Explode(player.Position, player, 55)
                end

                entity:Die()
            end
        end
    end
end

function this.Init() 
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, this.update)
end

return this