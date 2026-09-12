function blurMC(agMC, agBlurX, agBlurY, agQuality)
{
   var _loc3_;
   var _loc1_;
   if(agMC.filterOn == undefined)
   {
      _loc3_ = new flash.filters.BlurFilter(agBlurX,agBlurY,agQuality);
      _loc1_ = new Array();
      _loc1_.push(_loc3_);
      agMC.filters = _loc1_;
      agMC.filterOn = true;
   }
}
function clearBlurMC(agMC)
{
   agMC.filters = null;
   delete agMC.filterOn;
}
function blurMap()
{
   map.core.stopAllTrader();
   map.core.road._xscale = 1;
   map.core.road._yscale = 1;
   map.core.road.oriX = map.core.road._x;
   map.core.road.oriY = map.core.road._y;
   map.core.road._x = map.core.player._x;
   map.core.road._y = map.core.player._y;
   blurMC(map.core,10,10,3);
}
function clearMap()
{
   map.core.road._xscale = 100;
   map.core.road._yscale = 100;
   map.core.road._x = map.core.road.oriX;
   map.core.road._y = map.core.road.oriY;
   clearBlurMC(map.core);
   map.core.resumeAllTrader();
}
