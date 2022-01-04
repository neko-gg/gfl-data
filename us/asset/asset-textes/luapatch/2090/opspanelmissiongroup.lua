local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionGroup)

local transReset = function(self)
	return self.uiHolder:GetUIElement("ScoreNode/Img_ResetBG",typeof(CS.UnityEngine.RectTransform));
end

local ShowReast = function(self)
	if self.holder.nextMissionSpotOrders.Count>0 then		
		if self.holder.nextMissionSpotOrders[0].CurrentMissionId ~= 0 then
			return true;
		end					
	end
	return false;
end
util.hotfix_ex(CS.OPSPanelMissionGroup,'get_transReset',transReset)
util.hotfix_ex(CS.OPSPanelMissionGroup,'ShowReast',ShowReast)
