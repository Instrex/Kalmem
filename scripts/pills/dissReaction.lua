local this = {}
this.id = Isaac.GetPillEffectByName("Dissociative Reaction")

function this:soultesPill(soultemesisPill)
  local player = Isaac.GetPlayer(0)
  local hearts = player:GetSoulHearts() - 1
  player:AddSoulHearts(0 - (hearts + 1))
  for i = 0, hearts do
    local room = Game():GetRoom()
    local position = Isaac.GetFreeNearPosition(player.Position,1)
    Isaac.Spawn(5, 10, 8, position, Vector(0, 0), player)
  end
end

Isaac.AddPillEffectToPool(this.id)

function this.Init()
  mod:AddCallback(ModCallbacks.MC_USE_PILL, this.soultesPill, this.id)
end

return this