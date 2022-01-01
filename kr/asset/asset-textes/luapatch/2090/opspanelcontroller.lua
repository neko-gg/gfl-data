local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local InitClockSelect = function(self,show,play)
	self:InitClockSelect(show,play);
	if self.currentPanelConfig.ContainerClockInfos:ContainsKey(CS.OPSPanelBackGround.currentContainerId) then
		local info = self.currentPanelConfig.ContainerClockInfos[CS.OPSPanelBackGround.currentContainerId];
		for i=0,info.missionIds.Count-1 do
			local missionid = info.missionIds[i][CS.OPSPanelController.difficulty];
			local mission = CS.GameData.listMission:GetDataById(missionid);
			if mission ~= nil then
				self.control.angleDragmin = -self.startAngle - i * self.control.useAverageStopAngle;
			end
		end
	end
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
	if self.campaionId == -51 and self.specialItemObj ~= nil and not self.specialItemObj:isNull() then
		self.specialItemObj:SetActive(CS.OPSPanelBackGround.currentContainerId == 5);
	end
	if self.campaionId == -51 and self.btnTitleTrans ~= nil and not self.btnTitleTrans:isNull() then
		self.btnTitleTrans.gameObject:SetActive(CS.OPSPanelBackGround.currentContainerId ~= 5 and CS.OPSPanelBackGround.currentContainerId ~= 6);
	end
	if self.campaionId == -51 and self.containerBackground ~= nil and not self.containerBackground:isNull() then
		self.containerBackground:SetActive(CS.OPSPanelBackGround.currentContainerId == 0);
		if CS.OPSPanelBackGround.currentContainerId == 0 then
			self.containerBackground.transform:Find("Background").gameObject:SetActive(true);
			self.containerBackground.transform:Find("Img_EyeBG").gameObject:SetActive(true);
			self.containerBackground.transform:Find("Img_Stage1").gameObject:SetActive(false);
			self.containerBackground.transform:Find("Img_Stage2").gameObject:SetActive(false);
			self.containerBackground.transform:Find("Img_Stage3").gameObject:SetActive(false);
			self.containerBackground.transform:Find("Img_Stage4").gameObject:SetActive(false);
			local id = 1;
			for i=0,CS.OPSPanelBackGround.Instance.opsMissionContainers.Count -1 do
				local container = CS.OPSPanelBackGround.Instance.opsMissionContainers[i];
				if container.id ~= 5 and container.id ~= 6 and not container:ShowClock()then
					id = CS.Mathf.Max(id, container.id);
				end
			end
			if id  == 1 then
				self.containerBackground.transform:Find("Img_Stage1").gameObject:SetActive(true);
			elseif id  == 2 then
				self.containerBackground.transform:Find("Img_Stage2").gameObject:SetActive(true);
			elseif id  == 3 then
				self.containerBackground.transform:Find("Img_Stage3").gameObject:SetActive(true);
			elseif id  == 4 then
				self.containerBackground.transform:Find("Img_Stage4").gameObject:SetActive(true);
			end
		end
	end
end
--local InitShowContainer = function(self)
	--self:InitShowContainer();	
--end
local PlayTime = function(self,play,forward,hour,min,duration)
	if self.campaionId == -51 then
		return;
	end
	self:PlayTime(play,forward,hour,min,duration);
end
local ShowClockTime = function(self,show,play)
	if self.campaionId == -51 then
		return;
	end
	self:ShowClockTime(show,play);
end
local Awake = function(self)
	self:Awake();
	CS.OPSPanelController.diffcluteNum = self.currentPanelConfig.diffclutyNum;
	CS.OPSPanelController.diffclutyRecord = CS.Mathf.Min(CS.OPSPanelController.diffclutyRecord, CS.OPSPanelController.diffcluteNum - 1);
	CS.OPSPanelController.difficulty = CS.OPSPanelController.diffclutyRecord;
end

local ShowTip = function(self,go)
	local index = go.transform:GetSiblingIndex();
	local iteminfo = CS.GameData.listItemInfo:GetDataById(CS.OPSConfig.Instance.opsShowItems[self.campaionId].showItemIds[index]);
	local posOffset = CS.UnityEngine.Vector3(-300, 100, 0);
	CS.CommonTipsContent.ShowTips(iteminfo.name, iteminfo.introduction, "", 9, go.transform:TransformPoint(posOffset), go.transform.parent, 100);
end

local OpenRuler = function(self)
	if self.highScoreObj~= nil and not self.highScoreObj:isNull() then
		local txt = self.highScoreObj.transform:Find("Main/Btn_Rule/URL"):GetComponent(typeof(CS.ExText));
		if not CS.System.String.IsNullOrEmpty(txt.text) then
			self:OpenAnnouncement(txt.text);
			return;
		end
	end
	self:OpenRuler();
end
local ShowItemRuler = function(self)
	if self.specialItemObj~= nil and not self.specialItemObj:isNull() then
		local txt = self.specialItemObj.transform:Find("MissionItems/Btn_Rule/URL"):GetComponent(typeof(CS.ExText));
		if not CS.System.String.IsNullOrEmpty(txt.text) then
			self:OpenAnnouncement(txt.text);
			return;
		end
	end
	self:ShowItemRuler();
end
util.hotfix_ex(CS.OPSPanelController,'InitClockSelect',InitClockSelect)
util.hotfix_ex(CS.OPSPanelController,'ShowContainerReturn',ShowContainerReturn)
--util.hotfix_ex(CS.OPSPanelController,'InitShowContainer',InitShowContainer)
util.hotfix_ex(CS.OPSPanelController,'PlayTime',PlayTime)
util.hotfix_ex(CS.OPSPanelController,'ShowClockTime',ShowClockTime)
util.hotfix_ex(CS.OPSPanelController,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelController,'ShowTip',ShowTip)
util.hotfix_ex(CS.OPSPanelController,'OpenRuler',OpenRuler)
util.hotfix_ex(CS.OPSPanelController,'ShowItemRuler',ShowItemRuler)