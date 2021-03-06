local util = require 'xlua.util'
xlua.private_accessible(CS.TheaterEchelonSelection)

local OnSelectFairy = function(self,fairy)
	self:OnListReturn();
    if self.curEditSlot ~= nil and self.curEditSlot.dataType == CS.TheaterFormationRectItem.DataType.Fairy and self.fairyListIsAlter then
    if fairy == nil then
        CS.TheaterTeamData.instance:RemoveAlterFairy(self.curEditSlot.cellId);
    else
        CS.TheaterTeamData.instance:AddAlterFairy(self.curEditSlot.cellId, fairy);
    end
    CS.TheaterTeamData.instance:ArrangeAlterFairy();
    self:RefreshExtraUI();
    self:RefreshBossScore();
    else
        if CS.UISimulatorFormation.isExist then
            CS.FormationFairyLabelController.Instance:TeamFairy(fairy);
            CS. UISimulatorFormation.Instance.goFormation:SetActive(true);
        else
            CS.TheaterTeamData.instance:SetFairy(fairy);
            self:RefreshTeamList();
        end
    end

    self.curEditSlot = nil;
end

util.hotfix_ex(CS.TheaterEchelonSelection,'OnSelectFairy',OnSelectFairy)