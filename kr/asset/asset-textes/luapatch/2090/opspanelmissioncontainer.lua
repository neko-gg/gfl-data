local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelMissionContainer)

local rotateControl = function(self)
	if self.rotateControl ~= nil then
		return self.rotateControl;
	end
	local ro = self.gameObject:GetComponent(typeof(CS.ImageRotateControl));
	if ro == nil then
		ro = self.gameObject:AddComponent(typeof(CS.ImageRotateControl));
	end
	return ro;
end

util.hotfix_ex(CS.OPSPanelMissionContainer,'get_rotateControl',rotateControl)

