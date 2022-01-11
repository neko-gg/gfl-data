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

local RefreshClockUI = function(self)
	self:RefreshClockUI();
	if CS.OPSPanelController.Instance.campaionId == -51 then
		local triangle = self.transform:Find("DialPlateHolder/DialPlate/Triangle");
		if 	triangle ~= nil then
			local rotateControl = triangle:GetComponent(typeof(CS.ImageRotateControl));
			local check = 1.0*self:ClearCount() / self:AllCount();
			print(self.id.."/"..check);
			rotateControl.angle = CS.Mathf.Lerp(0, 180, check);
		end
	end
end
util.hotfix_ex(CS.OPSPanelMissionContainer,'get_rotateControl',rotateControl)
util.hotfix_ex(CS.OPSPanelMissionContainer,'RefreshClockUI',RefreshClockUI)
