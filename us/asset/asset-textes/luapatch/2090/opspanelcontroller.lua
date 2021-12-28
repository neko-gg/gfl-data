local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local InitClockSelect = function(self,show,play)
	self:InitClockSelect(show,play);
	if self.clockSelectRing ~= nil and not self.clockSelectRing:isNull() then
		local title =  self.clockSelectRing.transform:Find("CurrentMission/Ring");
		local group = title:GetComponent(typeof(CS.UnityEngine.CanvasGroup));
		if group ~= nil then
			if show then 
				group.alpha = 1;
			else
				group.alpha = 0;
			end
		end
	end
end
local ShowContainerReturn = function(self,show,play)
	self:ShowContainerReturn(show,play);
	self:CheckEndlessPoint();
end
util.hotfix_ex(CS.OPSPanelController,'InitClockSelect',InitClockSelect)
util.hotfix_ex(CS.OPSPanelController,'ShowContainerReturn',ShowContainerReturn)