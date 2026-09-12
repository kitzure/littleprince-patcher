function initPrince()
{
   princeInit.gotoAndPlay(2);
}
function resumePrince()
{
   trace("princeInit" + princeInit);
   if(firstTimeEnter == undefined)
   {
      firstTimeEnter = true;
      princeInit.gotoAndPlay("init");
      playMusic("map" + mapEngine_Current,10000);
   }
   else
   {
      resumePCounter++;
      map.core.resume();
   }
}
function showFirstHint()
{
   if((user.extra & 8) == 0)
   {
      popup("langHint");
   }
   else if(user.firstHint)
   {
      popup("firstHint");
   }
   else
   {
      showPrince();
   }
   map.core.player._visible = true;
}
function resumeFirstHint()
{
   saveUserData(user);
   popupClip.gotoAndStop(1);
   clearMap();
   showPrince();
}
function resumeLangHint()
{
   saveUserData(user);
   if(user.firstHint)
   {
      popupClip.gotoAndStop("firstHint");
   }
   else
   {
      popupClip.gotoAndStop(1);
      clearMap();
      showPrince();
   }
}
function resumeDemo()
{
   popupClip.gotoAndStop(1);
   clearMap();
   showPrince();
}
function showPrince()
{
   header.showSmallMap();
   map.core.player._visible = true;
   map.core.resume();
   header.enableRightPane();
}
resumePCounter = 0;
