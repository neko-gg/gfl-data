local util = require 'xlua.util'
xlua.private_accessible(CS.AVGTrigger)

local PlayMissionEndWinAVG = function(self)
	self.scriptName = nil;
	self:PlayMissionEndWinAVG();
end

util.hotfix_ex(CS.AVGTrigger,'PlayMissionEndWinAVG',PlayMissionEndWinAVG)
