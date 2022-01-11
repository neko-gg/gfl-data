local util = require 'xlua.util'
xlua.private_accessible(CS.GuideDeploymentController)

local FinishCurrentStep = function(self)
	if CS.GuideDeploymentController.currentGuideStep == nil then
		return;
	end
	self:FinishCurrentStep();
end
util.hotfix_ex(CS.GuideDeploymentController,'FinishCurrentStep',FinishCurrentStep)

