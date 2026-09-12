function addGem(agGemID, agAmount, checkEnabled, animation)
{
   var _loc2_ = 0;
   var _loc1_ = 0;
   if(agGemID > 20)
   {
      _loc2_ = agGemID - 20;
      _loc1_ = agAmount * 10;
   }
   else if(agGemID > 10)
   {
      _loc2_ = agGemID - 10;
      _loc1_ = agAmount * 5;
   }
   else
   {
      _loc2_ = agGemID;
      _loc1_ = agAmount;
   }
   header.addGem(_loc2_,_loc1_,checkEnabled,animation);
   user.report.addGem(_loc2_,_loc1_);
   saveUserData(user);
}
function reduceMapGem(agGemID, agAmount)
{
   var _loc4_ = 0;
   var _loc1_;
   var _loc3_;
   var _loc2_;
   while(_loc4_ < agAmount)
   {
      _loc1_ = 0;
      while(_loc1_ < mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].length)
      {
         if(mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc1_] == agGemID)
         {
            _loc3_ = mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].slice(0,_loc1_);
            _loc2_ = mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].slice(_loc1_ + 1,mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].length);
            mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65] = _loc3_.concat(_loc2_);
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      _loc4_ = _loc4_ + 1;
   }
}
function reduceGem(agGemID, agAmount, checkEnabled)
{
   traceOut("reduceGem(" + agGemID + ", " + agAmount + "," + checkEnabled + ")");
   header.reduceGem(agGemID,agAmount,checkEnabled);
   user.report.reduceGem(agGemID,agAmount);
   saveUserData(user);
}
function showBuyItem(agTraderID)
{
   currentTraderID = agTraderID;
   header.killSmallMap();
   blurMap();
   header.hidePaneR();
   switchFile([{file:"traderStore.swf",showNow:true,loc:"traderStore"}]);
   playMusic("trader",10000);
   fadeOutMusic("map" + mapEngine_Current,25);
}
function showSPShop()
{
   this.header.hideLogo();
   this.mapName.gotoAndStop(1);
   header.killSmallMap();
   blurMap();
   header.hidePaneR();
   switchFile([{file:"traderinmap.swf",showNow:true,loc:"traderStore"}]);
   playMusic("trader",10000);
   fadeOutMusic("map" + mapEngine_Current,25);
}
function showShadowMsg()
{
   this.header.hideLogo();
   this.mapName.gotoAndStop(1);
   header.killSmallMap();
   blurMap();
   header.hidePaneR();
   switchFile([{file:"shadowinmap.swf",showNow:true,loc:"traderStore"}]);
   playMusic("trader",10000);
   fadeOutMusic("map" + mapEngine_Current,25);
}
function createGemItem(agTraderID, agGemArr)
{
   var _loc5_ = 0;
   var _loc2_ = 0;
   var _loc1_;
   while(_loc2_ < itemSpec["trader" + agTraderID].dat.length)
   {
      _loc1_ = 0;
      while(_loc1_ < itemSpec["trader" + agTraderID].dat[_loc2_].pattern.length)
      {
         if(agGemArr[_loc1_] != itemSpec["trader" + agTraderID].dat[_loc2_].pattern[_loc1_])
         {
            break;
         }
         if(_loc1_ == itemSpec["trader" + agTraderID].dat[_loc2_].pattern.length - 1 && agGemArr[_loc1_] == itemSpec["trader" + agTraderID].dat[_loc2_].pattern[_loc1_])
         {
            return _loc2_ + 1;
         }
         _loc1_ = _loc1_ + 1;
      }
      _loc2_ = _loc2_ + 1;
   }
   return _loc5_;
}
function addItemList(agTraderID, agItemID, agAmount)
{
   traceOut("index.addItemList(" + agTraderID + "," + agItemID + ", " + agAmount + ")");
   user.report.addItem(agTraderID + "-" + (agItemID - 1),agAmount);
   saveUserData(user);
}
