local util = require 'xlua.util'
xlua.private_accessible(CS.OPSPanelController)

local InitClockSelect = function(self,show,play)
	if CS.GameData.missionAction ~= nil then
		self.selectProcess = true;
		self.missionIdTemp = CS.GameData.missionAction.missionInfo.id;
	end
	if self.clockSelectRing ~= nil and not self.clockSelectRing:isNull() then
		local parentRing = self.clockSelectRing.transform:Find("Ring");
		for i=0,parentRing.childCount-1 do
			local image = parentRing:GetChild(i):GetComponent(typeof(CS.ExImage));
			image:DOKill();
		end
	end
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
		local title =  self.clockSelectRing.transform:Find("CurrentMission");
		if title ~= nil then
			local group = title:GetComponent(typeof(CS.UnityEngine.CanvasGroup));
			if group ~= nil and not group:isNull() then
				if show then 
					group.alpha = 1;
				else
					group.alpha = 0;
				end
			end
		end
	end
	self.selectProcess = false;
end
local CheckCurrentAngle = function(self,order)
	self:CheckCurrentAngle(order);
	if self.clockSelectRing ~= nil and not self.clockSelectRing:isNull() then
		local title =  self.clockSelectRing.transform:Find("CurrentMission");
		if title ~= nil then
			local group = title:GetComponent(typeof(CS.UnityEngine.CanvasGroup));
			if group ~= nil and not group:isNull() then
				group:DOKill();
				group.alpha = 1;
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
		local main = self.leftMain:Find("FixedPoint_Left(Clone)/Main");
		if CS.OPSPanelBackGround.currentContainerId ~= 5 and CS.OPSPanelBackGround.currentContainerId ~= 6 then
			self.btnTitleTrans.gameObject:SetActive(true);
			if main ~= nil then
				local mainTrans = main:GetComponent(typeof(CS.UnityEngine.RectTransform));
				main:DOAnchorPosY(420,0.5);
			end
		else
			self.btnTitleTrans.gameObject:SetActive(false);
			if main ~= nil then
				local mainTrans = main:GetComponent(typeof(CS.UnityEngine.RectTransform));
				main:DOAnchorPosY(300,0.5);
			end
		end		
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
checkScale = false;
local ReturnContainer = function(self)
	if not self.CanClick then
		return;
	end
	checkScale = true;
	self:ReturnContainer();
	CS.CommonController.Invoke(function()
		CS.OPSPanelBackGround.Instance:ReadRecord();
		end,0.7,CS.OPSPanelController.Instance);
end
local CheckSpineSpot = function(self)
	if self.currentContainer ~= nil and not self.currentContainer:isNull() then
		if self.currentContainer.clockinfo ~= nil then
			return;
		end
	end
	self:CheckSpineSpot();
end

local RefreshUI = function(self,onlyrefreshLabel)
	self:RefreshUI(onlyrefreshLabel);
	if self.currentContainer ~= nil and not self.currentContainer:isNull() then
		self.currentContainer:RefreshUI();
	end
end

local CancelMission = function(self)
	self:CancelMission();
	if self.currentContainer ~= nil and not self.currentContainer:isNull() then
		self:InitClockSelect(true, false);
	end
end


local InitBgm=function(self)
	self:InitBgm();
	local request=CS.RequestDrawEvent(CS.OPSPanelController.OpenCompaions);
	request:Request();
end
util.hotfix_ex(CS.OPSPanelController,'InitClockSelect',InitClockSelect)
util.hotfix_ex(CS.OPSPanelController,'ShowContainerReturn',ShowContainerReturn)
util.hotfix_ex(CS.OPSPanelController,'CheckCurrentAngle',CheckCurrentAngle)
util.hotfix_ex(CS.OPSPanelController,'PlayTime',PlayTime)
util.hotfix_ex(CS.OPSPanelController,'ShowClockTime',ShowClockTime)
util.hotfix_ex(CS.OPSPanelController,'Awake',Awake)
util.hotfix_ex(CS.OPSPanelController,'ShowTip',ShowTip)
util.hotfix_ex(CS.OPSPanelController,'OpenRuler',OpenRuler)
util.hotfix_ex(CS.OPSPanelController,'ShowItemRuler',ShowItemRuler)
util.hotfix_ex(CS.OPSPanelController,'ReturnContainer',ReturnContainer)
util.hotfix_ex(CS.OPSPanelController,'CheckSpineSpot',CheckSpineSpot)
util.hotfix_ex(CS.OPSPanelController,'RefreshUI',RefreshUI)
util.hotfix_ex(CS.OPSPanelController,'CancelMission',CancelMission)
--util.hotfix_ex(CS.OPSPanelController,'InitBgm',InitBgm)