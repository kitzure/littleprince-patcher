function checkLogin()
{
   if(ver != "webedcity")
   {
      preloadFile([{file:"login.swf",showNow:true,loc:"login"}]);
   }
   unloadFile(["animation"]);
}
function loadSystem()
{
   var _loc1_ = randomMap();
   switchFile([{file:_loc1_,showNow:true,loc:"map"},{file:"header.swf",showNow:true,loc:"header"},{file:"gamebar.swf",showNow:false,loc:"gameBar"}],["login"],showMapName);
   getUserResolution();
   setUserQuality(user.quality);
   setUserWinMode(user.winmode);
}
function switchFile(toLoad, toUnload, toDo)
{
   hideHint();
   preloadFile(toLoad);
   traceOut("switchFile");
   unloadFile(toUnload);
   completeAction = toDo;
   traceOut("currentframe:" + this._currentframe);
}
function randomMap()
{
   var _loc1_ = random(3);
   if(_loc1_ == 0)
   {
      mapEngine_Current = "A";
   }
   else if(_loc1_ == 1)
   {
      mapEngine_Current = "B";
   }
   else
   {
      mapEngine_Current = "C";
   }
   return getCurrentMapSWF(mapEngine_Current);
}
function getCurrentMapSWF()
{
   traceOut("getCurrentMapSWF()");
   if(mapEngine_Current == "B")
   {
      return "map_garden.swf";
   }
   if(mapEngine_Current == "C")
   {
      return "map_candy.swf";
   }
   if(mapEngine_Current == "D")
   {
      return "map_final.swf";
   }
   if(mapEngine_Current == "E")
   {
      return "map_glass.swf";
   }
   return "map_question.swf";
}
function callGame(pmGame)
{
   header.togglePaneRButton(false);
   gameID = pmGame;
   map.core["panel" + pmGame].gotoAndPlay("leave");
   header.killSmallMap();
   counter = 0;
   steps = 10;
   jumpScale = 100;
   oriY = map.core.player._y;
   moveX = (map.core["building" + gameID]._x - map.core.player._x + map.core["building" + gameID].gas._x) / steps;
   moveY = (map.core["building" + gameID]._y - map.core.player._y + map.core["building" + gameID].gas._y) / steps;
   if(moveX > 0)
   {
      map.core.player.gotoAndStop(2);
   }
   else
   {
      map.core.player.gotoAndStop(8);
   }
   onEnterFrame = function()
   {
      if(counter > steps)
      {
         moveBuilding(pmGame);
         map.core["building" + gameID].gas.gotoAndPlay("enter");
         delete counter;
         delete steps;
         delete jumpScale;
         delete oriY;
         delete moveX;
         delete moveY;
      }
      else
      {
         counter++;
         map.core.player._x += moveX;
         map.core.player._y = oriY + moveY * counter - Math.sin(counter / steps * 180 * 3.141592653589793 / 180) * jumpScale;
         map.core.player._xscale -= 5;
         map.core.player._yscale = map.core.player._xscale;
         if(counter > 3)
         {
            map.core.player.dir.gotoAndStop(2);
         }
         else
         {
            map.core.player.dir.gotoAndStop(1);
         }
      }
      if(counter == 5)
      {
         playFx("togame");
      }
   };
}
function moveBuilding(pmGame)
{
   map.core.player._visible = false;
   counterT = 0;
   counterS = 0;
   incre = 1;
   onEnterFrame = function()
   {
      counterT++;
      counterS += incre;
      if(counterT > 15)
      {
         loadGame(gameID);
         delete onEnterFrame;
      }
      else if(counterT <= 10)
      {
         map.core["building" + gameID].core._xscale = 100 + 15 * Math.sin(counterS) - counterT * 0.5;
         map.core["building" + gameID].core._yscale = 100 + 10 * Math.cos(counterS) - counterT * 0.5;
      }
   };
}
function prepareBoss()
{
   playFx("ding");
   header.leaveHeader();
   killMapName();
   header.hideLogo();
   header.killSmallMap();
}
function loadBoss()
{
   bossStatus = "preBoss";
   fadeOutBossMusic();
   showBossTransition("question");
}
function callBoss()
{
   fadeOutBossMusic();
   showBossTransition("start");
}
function callBossQuestion()
{
   bossStatus = "question";
   switchFile([{file:"question.swf",showNow:true,loc:"bossQ"}],["map","header"],hideBossTransition);
}
function callFinalBossQuestion()
{
   blurMap();
   switchFile([{file:"question.swf",showNow:true,loc:"bossQ"}],["header"]);
}
function resumeFinalBossQuestion(type)
{
   clearMap();
   if(type == "open")
   {
      map.openGate();
   }
   else
   {
      map.resumeStone();
   }
   switchFile([{file:"header.swf",showNow:true,loc:"header"}],[]);
}
function callBossBattle()
{
   bossStage = 0;
   switch(mapEngine_Current)
   {
      case "A":
         bossStage = 1;
         break;
      case "B":
         bossStage = 2;
         break;
      case "C":
         bossStage = 3;
         break;
      case "E":
         bossStage = 5;
         break;
      default:
         bossStage = 4;
         fadeOutMusic("mapD",15);
   }
   switchFile([{file:"bossBar.swf",showNow:true,loc:"gameBar"},{file:"bossBattle" + bossStage + ".swf",showNow:true,loc:"game"},{file:"bossAni.swf",showNow:false,loc:"animation"}],["header","map","bossQ"],hideBossTransition);
}
function callCastle()
{
   unloadFile(["game"]);
   switchFile([{file:"bossAni.swf",showNow:true,loc:"animation"}],[]);
   fadeOutBossMusic();
}
function loadGame(pmGame)
{
   switchFile([{file:"game" + pmGame + "/game" + pmGame + ".swf",showNow:true,loc:"game"},{file:"game" + pmGame + "/instruction.swf",showNow:false,loc:""},{file:"gamebar.swf",showNow:true,loc:"gameBar"}],["map"]);
   header.showGameName(pmGame);
   header.leaveMap();
   if(gameID <= 6)
   {
      zone = 1;
      loadingColor = "pink";
   }
   else if(gameID <= 9)
   {
      zone = 2;
      loadingColor = "green";
   }
   else if(gameID <= 17)
   {
      zone = 3;
      loadingColor = "orange";
   }
   else
   {
      zone = 4;
      loadingColor = "orange";
   }
   killMapName();
   header.hideLogo();
   fadeOutMusic("map" + mapEngine_Current,25);
}
function loadSPShop()
{
   transition.gotoAndPlay("enter spshop");
}
function loadSPShop2()
{
   mapEngine_From = "shop";
   unloadFile(["map"]);
   switchFile([{file:"lucky.swf",showNow:true,loc:"game"}],["game","gameBar"],hideTransition);
   killMapName();
   header.hideLogo();
}
function hideTransition()
{
   transition.gotoAndPlay("leave spshop");
}
function unloadSPShop()
{
   loadMap();
}
function switchMap()
{
   showMapTransition();
   killMapName();
}
function loadMap()
{
   var _loc1_ = getCurrentMapSWF();
   switchFile([{file:_loc1_,showNow:true,loc:"map"}],["game","gameBar"],hideMapTransition);
}
function loadMapFromBoss()
{
   var _loc1_ = getCurrentMapSWF();
   switchFile([{file:_loc1_,showNow:true,loc:"map"}],["game","gameBar","animation","bossQ"],hideBossTransition);
}
function leaveTrader()
{
   traderStore.clearGem();
   unloadFile(["traderStore"]);
   header.disableGems();
   clearMap();
   if(user.type == 2)
   {
      header.showPaneR("admin");
   }
   else
   {
      header.showPaneR("normal");
   }
   map.core.resume();
   showMapName();
   fadeOutMusic("trader",25);
   playMusic("map" + mapEngine_Current,10000);
}
function selInSPShop(sel)
{
   unloadFile(["traderStore"]);
   clearMap();
   if(sel)
   {
      map.core.pause();
      map.core.mc_merchant.gotoAndPlay("fly");
      map.core.player._visible = false;
   }
   else
   {
      if(user.type == 2)
      {
         header.showPaneR("admin");
      }
      else
      {
         header.showPaneR("normal");
      }
      map.core.resume();
      map.core.mc_merchant.play();
      map.core.mc_merchant.message.gotoAndPlay(1);
      showMapName();
      fadeOutMusic("trader",25);
      playMusic("map" + mapEngine_Current,10000);
   }
}
function selInShadow(sel)
{
   unloadFile(["traderStore"]);
   clearMap();
   if(sel)
   {
      map.core.pause();
      fadeOutMusic("trader",25);
      callBoss();
   }
   else
   {
      if(user.type == 2)
      {
         header.showPaneR("admin");
      }
      else
      {
         header.showPaneR("normal");
      }
      map.core.resume();
      map.core.shadow.play();
      map.core.shadow.message.gotoAndPlay(2);
      showMapName();
      fadeOutMusic("trader",25);
      playMusic("map" + mapEngine_Current,10000);
   }
}
function toggleOnTop(type)
{
   if(onTop != type)
   {
      if(type)
      {
         clearMap();
         header.showLogo();
         header.showSmallMap();
         map.core.resume();
      }
      else
      {
         blurMap();
         map.core.pause();
         header.hideLogo();
         killMapName();
         header.killSmallMap();
      }
      onTop = type;
   }
}
function loadReport()
{
   toggleOnTop(false);
   switchFile([{file:"report.swf",showNow:true,loc:"report"}],["equip","mirror","admin","help"]);
}
function killReport()
{
   toggleOnTop(true);
   unloadFile(["report"]);
}
function loadEquip()
{
   toggleOnTop(false);
   switchFile([{file:"equip.swf",showNow:true,loc:"equip"}],["report","mirror","admin","help"]);
}
function killEquip()
{
   toggleOnTop(true);
   unloadFile(["equip"]);
}
function loadMirror()
{
   if(mirrorStatus == "normal")
   {
      toggleOnTop(false);
   }
   switchFile([{file:"mirror.swf",showNow:true,loc:"mirror"}],["report","equip","admin","help"]);
}
function killMirror(pmType)
{
   trace(pmType);
   if(pmType == "normal")
   {
      toggleOnTop(true);
   }
   unloadFile(["mirror"]);
}
function loadAdmin()
{
   toggleOnTop(false);
   switchFile([{file:"admin.swf",showNow:true,loc:"admin"}],["report","mirror","equip","help"]);
}
function killAdmin()
{
   toggleOnTop(true);
   unloadFile(["admin"]);
}
function loadHelp()
{
   toggleOnTop(false);
   switchFile([{file:"help.swf",showNow:true,loc:"help"}],["admin","report","mirror","equip"]);
}
function killHelp()
{
   toggleOnTop(true);
   unloadFile(["help"]);
}
function showEnding()
{
   switchFile([{file:"ending.swf",showNow:true,loc:"animation"}]);
}
