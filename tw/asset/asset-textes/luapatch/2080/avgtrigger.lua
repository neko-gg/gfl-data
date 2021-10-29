local util = require 'xlua.util'
xlua.private_accessible(CS.AVGTrigger)

local PlayMissionEndWinAVG = function(self)
	self.scriptName = nil;
	self:PlayMissionEndWinAVG();
end

local ScriptName = function(self,currentMission,script)
	if currentMission.winCount == 1 and CS.GameData.missionResult ~= nil then
		self:ScriptEndName(script);
		return;
	end
	self:ScriptName(currentMission,script);
end
util.hotfix_ex(CS.AVGTrigger,'PlayMissionEndWinAVG',PlayMissionEndWinAVG)
util.hotfix_ex(CS.AVGTrigger,'ScriptName',ScriptName)