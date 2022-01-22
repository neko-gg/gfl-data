local util = require 'xlua.util'
local config = require '2090/SLGMinigame/BattleSLGModeConfig'
xlua.private_accessible(CS.GF.Battle.BattleController)

local CheckIsSLGMode = function(self)
	--print(CS.GameData.engagedSpot.enemyTeamId)
	for i=1,#minigameEnemyGroupID do
		if CS.GameData.engagedSpot.enemyTeamId == minigameEnemyGroupID[i] then
			return true
		end
	end
	return false
	
end

util.hotfix_ex(CS.GF.Battle.BattleController,'CheckIsSLGMode',CheckIsSLGMode)
