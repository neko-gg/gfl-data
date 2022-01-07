local util = require 'xlua.util'
xlua.private_accessible(CS.ResearchEquipmentStrengthenController)
xlua.private_accessible(CS.CommonEquipmentListController.EquipmentChooseDataEventArgs)
local _OnOpenEquipmentList = function(self)
    self.mainChosenData.SortMode=false;
    self:OnOpenEquipmentList();
end
util.hotfix_ex(CS.ResearchEquipmentStrengthenController,'OnOpenEquipmentList',_OnOpenEquipmentList)