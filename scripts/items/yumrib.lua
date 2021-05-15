local this = {}
this.id = Isaac.GetItemIdByName("Yum Rib")
this.description = "Gives one bone heart"
this.rusdescription = {"Yum Rib /��� �����", "��� ���� �������� ������"}
this.isActive = true

function this.use(id,rng,player,useflags,slot,vardata)
	local player = Isaac.GetPlayer()
	player:AddBoneHearts(1)
    sfx:Play(461, 0.8, 0, false, 1)
	if utils.chancep(16.5) then
		player:ChangePlayerType(PlayerType.PLAYER_THEFORGOTTEN)
		player:RemoveCollectible(this.id)
	end
	return true
end

function this.Init()
	mod:AddCallback(ModCallbacks.MC_USE_ITEM, this.use, this.id)
end

return this