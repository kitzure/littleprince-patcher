function initMapObj()
{
   mapObj = new Object();
   mapObj.traderLoc = new Array();
   var _loc1_ = 0;
   while(_loc1_ < 6)
   {
      mapObj.traderLoc[_loc1_] = String.fromCharCode(64 + Math.floor(Math.random() * 3 + 1));
      _loc1_ = _loc1_ + 1;
   }
   mapObj.mapGem = new Array();
   _loc1_ = 0;
   while(_loc1_ < 3)
   {
      mapObj.mapGem[_loc1_] = new Array();
      _loc1_ = _loc1_ + 1;
   }
}
