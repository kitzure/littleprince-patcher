function showMapName()
{
   if(mapEngine_Current == undefined)
   {
      mapEngine_Current = "A";
   }
   mapName.gotoAndPlay("map" + mapEngine_Current);
   mapName.counter = 0;
   mapName.onEnterFrame = function()
   {
      this.counter = this.counter + 1;
      if(this.counter > 125)
      {
         this.gotoAndPlay("map" + mapEngine_Current + "fade");
         delete this.counter;
         delete this.onEnterFrame;
      }
   };
   if(user.type == 2)
   {
      header.showPaneR("admin");
   }
   else
   {
      header.showPaneR("normal");
   }
   if(firstTimeEnter == undefined)
   {
      map.core.player._visible = false;
   }
   else
   {
      header.showSmallMap();
   }
}
function killMapName()
{
   delete mapName.onEnterFrame;
   delete mapName.counter;
   mapName.gotoAndStop(1);
}
function showMapTransition()
{
   transition.gotoAndPlay("enter");
   header.hidePaneR();
   header.killSmallMap();
   fadeOutMusic("map" + mapEngine_From,50);
   delete mapName.onEnterFrame;
   header.hideLogo();
}
function hideMapTransition()
{
   transition.gotoAndPlay("leave");
   playMusic("map" + mapEngine_Current,10000);
}
function showBossTransition(which)
{
   bossStatus = which;
   bossTransition.gotoAndPlay("enter");
   fadeOutBossMusic();
}
function hideBossTransition()
{
   playBossMusic();
   bossTransition.gotoAndPlay("leave");
}
function startBossBattle()
{
   gameBar.startCount();
}
function resumeMapFromBoss()
{
   fadeOutBossMusic();
   if(bossStatus != "success")
   {
      playMusic("map" + mapEngine_Current,10000);
   }
   if(bossDefeat == "success" and user.hasDefeatedBoss(bossStage) == 1)
   {
      map.core.stopAllTrader();
      map.core.iCentre.gotoAndPlay("ani");
      updateBoss(bossStage);
   }
   else
   {
      resumeDefeatBoss();
   }
   resumeFromBoss = true;
   delete bossStatus;
   delete bossDefeat;
}
function resumeDefeatBoss()
{
   switchFile([{file:"header.swf",showNow:true,loc:"header"}],[]);
   map.core.resume();
   map.core.resumeAllTrader();
   showMapName();
   header.showSmallMap();
   playMusic("map" + mapEngine_Current,10000);
}
