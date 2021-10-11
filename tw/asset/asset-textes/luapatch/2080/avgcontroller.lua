local util = require 'xlua.util'
xlua.private_accessible(CS.AVGController)

local DestoryAVG = function(self)
	self:DestoryAVG();
	if CS.OPSPanelController.Instance ~= nil and not CS.OPSPanelController.Instance:isNull() then
		CS.OPSPanelController.Instance:InitBgm();
		CS.OPSPanelController.Instance:RefreshUI();
		CS.OPSPanelController.Instance:CheckAnim();
	end
end
local DialogueShowContentEmpty = function(self)
	
end
local OnClickHideUi = function(self)
	if not self.isHidingUI then
		xlua.hotfix(CS.AVGController,'DialogueShowContent',DialogueShowContentEmpty);
		self:OnClickHideUi();
		xlua.hotfix(CS.AVGController,'DialogueShowContent',nil);
	else
		self:OnClickHideUi();
	end
end
--util.hotfix_ex(CS.AVGController,'DestoryAVG',DestoryAVG)
util.hotfix_ex(CS.AVGController,'OnClickHideUi',OnClickHideUi)
