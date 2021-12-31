local util = require 'xlua.util'
xlua.private_accessible(CS.MissionAction)


local LoadBattleEnvironment = function(self,jsonData)
	self:LoadBattleEnvironment(jsonData);
	local text = Split(self.environmentTxt,"|");
	local iter = self.currentEnvironmentSkill:GetEnumerator();     
	while iter:MoveNext() do                      
		local layer = iter.Current.Key;
        if CS.System.String.IsNullOrEmpty(text[layer]) then
			if self.currentEnvironmentSkill:ContainsKey(layer) then
				self.currentEnvironmentSkill[layer]:Clear();
			end
		end          
	end	
end


function Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
		end
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

util.hotfix_ex(CS.MissionAction,'LoadBattleEnvironment',LoadBattleEnvironment)