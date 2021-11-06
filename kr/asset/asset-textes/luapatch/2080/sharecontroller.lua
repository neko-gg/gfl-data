local util = require 'xlua.util'
xlua.private_accessible(CS.ShareButtonController)
xlua.private_accessible(CS.ShareController)
local _OnClick = function(self)
	self:OnClick();--ePlatform_Normal ePlatform_Korea
	if CS.HotUpdateController.instance.mUsePlatform == CS.HotUpdateController.EUsePlatform.ePlatform_Korea then
		if self.shareController ~=nil then
			if self.shareController.btnKakao~=nil then
				self.shareController.btnKakao.gameObject:SetActive(false);
			end
		end
	end
end
util.hotfix_ex(CS.ShareButtonController,'OnClick',_OnClick)
