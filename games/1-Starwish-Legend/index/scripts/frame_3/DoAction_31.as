function getMapInfo(agReturnFrom)
{
   var _loc2_ = new Array();
   var _loc3_ = 0;
   var _loc1_;
   if(agReturnFrom == 1)
   {
      _loc1_ = 0;
      while(_loc1_ < 6)
      {
         mapObj.traderLoc[_loc1_] = "ABCE".substr(random(4),1);
         _loc1_ = _loc1_ + 1;
      }
   }
   _loc2_[0] = mapObj.traderLoc.slice(0);
   _loc1_ = 0;
   while(_loc1_ <= _loc2_[0].length)
   {
      if(_loc2_[0][_loc1_] == mapEngine_Current)
      {
         _loc3_ = _loc3_ + 1;
      }
      _loc1_ = _loc1_ + 1;
   }
   groupGem();
   if(mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].length > 20 - _loc3_)
   {
      _loc2_[1] = mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].slice(0,20 - _loc3_);
   }
   else
   {
      _loc2_[1] = mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].slice(0);
   }
   return _loc2_;
}
function setMapGem(agGemArr)
{
   traceOut("setMapGem(" + agGemArr.toString() + ")");
   var _loc1_ = 0;
   while(_loc1_ < agGemArr.length)
   {
      mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].push(agGemArr[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
}
function groupGem()
{
   var _loc1_ = [0,0,0,0,0,0,0,0,0,0];
   var _loc3_ = new Array();
   traceOut("mapGem: " + mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65]);
   var _loc2_ = 0;
   while(_loc2_ < mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65].length)
   {
      if(mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc2_] > 20)
      {
         _loc1_[mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc2_] - 21] = _loc1_[mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc2_] - 21] + 10;
      }
      else if(mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc2_] > 10 && mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc2_] <= 20)
      {
         _loc1_[mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc2_] - 11] = _loc1_[mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc2_] - 11] + 5;
      }
      else
      {
         _loc1_[mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65][_loc2_] - 1]++;
      }
      _loc2_ = _loc2_ + 1;
   }
   while(_loc1_[0] + _loc1_[1] + _loc1_[2] + _loc1_[3] + _loc1_[4] + _loc1_[5] + _loc1_[6] + _loc1_[7] + _loc1_[8] + _loc1_[9] != 0)
   {
      traceOut(_loc1_[0] + _loc1_[1] + _loc1_[2] + _loc1_[3] + _loc1_[4] + _loc1_[5] + _loc1_[6] + _loc1_[7] + _loc1_[8] + _loc1_[9]);
      _loc2_ = 0;
      while(_loc2_ < 10)
      {
         if(_loc1_[_loc2_] >= 10)
         {
            _loc3_.push(_loc2_ + 1 + 20);
            _loc1_[_loc2_] -= 10;
         }
         else if(_loc1_[_loc2_] >= 5)
         {
            _loc3_.push(_loc2_ + 1 + 10);
            _loc1_[_loc2_] -= 5;
         }
         else if(_loc1_[_loc2_] > 0)
         {
            _loc3_.push(_loc2_ + 1);
            _loc1_[_loc2_] = _loc1_[_loc2_] - 1;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65] = _loc3_;
   traceOut("tmpGem: " + _loc1_);
   traceOut("mapGem: " + mapObj.mapGem[mapEngine_Current.charCodeAt(0) - 65]);
}
