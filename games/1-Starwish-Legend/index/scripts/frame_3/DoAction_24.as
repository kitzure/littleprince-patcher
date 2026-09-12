function prepareLoadingPopup()
{
   popupClip.gotoAndStop("loading");
}
function popup(whichType, param, dark)
{
   map.core.pause();
   popupStatus = whichType;
   traderStore.mapIsMoving = true;
   hideCursor(true);
   isPopup = true;
   if(whichType == "loading")
   {
      popupClip.gotoAndStop("loading");
   }
   else if(whichType == "error")
   {
      playFx("slide");
      popupClip.gotoAndStop("error");
      popupClip.core.msg._visible = false;
      popupClip.core.bttn1._visible = false;
      popupClip.core.msgVar = param[0];
      popupClip.core.bttn1.onRollOver = function()
      {
         playFx("drag");
      };
      popupClip.core.bttn1.onRelease = function()
      {
         killPopup();
         restartSys();
      };
   }
   else if(whichType == "question" or whichType == "message")
   {
      playFx("slide");
      popupClip.gotoAndStop("question");
      popupClip.core.msg._visible = false;
      popupClip.core.bttn1._visible = false;
      popupClip.core.bttn2._visible = false;
      popupClip.core.msgVar = param[0];
      popupClip.core.bttn1.onRelease = function()
      {
         killPopup();
         param[1]();
      };
      popupClip.core.bttn1.onRollOver = function()
      {
         playFx("drag");
      };
      popupClip.core.bttn2.onRollOver = function()
      {
         playFx("drag");
      };
      if(whichType == "question")
      {
         popupClip.core.bttn2.onRelease = function()
         {
            killPopup();
            param[2]();
         };
      }
      else if(whichType == "message")
      {
         popupClip.core.bttn2.onRelease = function()
         {
            killPopup();
         };
      }
   }
   else if(whichType == "vo")
   {
      popupClip.gotoAndStop("vo");
      popupClip.core.voNo = param;
      popupClip.core.totalWidth = popupClip.core.voProgress._width;
      popupClip.core.voProgress._width = 0;
   }
   else if(whichType == "firstHint")
   {
      popupClip.gotoAndStop("firstHint");
      blurMap();
   }
   else if(whichType == "demo")
   {
      popupClip.gotoAndStop("demo");
      blurMap();
   }
   else if(whichType == "langHint")
   {
      popupClip.gotoAndStop("langHint");
      blurMap();
   }
   else if(whichType == "alert")
   {
      playFx("slide");
      popupClip.gotoAndStop("alert");
      popupClip.core.msg._visible = false;
      popupClip.core.bttn1._visible = false;
      popupClip.core.msgVar = param[0];
      popupClip.core.bttn1.onRollOver = function()
      {
         playFx("drag");
      };
      popupClip.core.bttn1.onRelease = function()
      {
         killPopup();
      };
   }
   else if(whichType == "setting")
   {
      map.core.stopAllTrader();
      popupClip.gotoAndStop("setting");
   }
   if(dark)
   {
      popupClip.darkMask._height = 600;
   }
   else
   {
      popupClip.darkMask._height = 561;
   }
}
function showVOProgress(amount)
{
   popupClip.core.voProgress._width = Math.round(amount / popupClip.core.voNo * popupClip.core.totalWidth);
}
function killPopup()
{
   showCursor("reuse");
   delete traderStore.mapIsMoving;
   hideHint();
   popupClip.gotoAndStop(1);
   delete popupStatus;
   delete isPopup;
}
function resumeMap()
{
   map.core.resume();
}
function adjustPopupText(bttnMargin)
{
   var _loc1_ = Math.round((popupClip.core.centre._height - popupClip.core.msg.textHeight - bttnMargin) / 2);
   popupClip.core.msg._y = popupClip.core.upper._y + _loc1_ - 5;
   popupClip.core.bttn1._y = popupClip.core.upper._y + popupClip.core.msg.textHeight + bttnMargin - 5;
   popupClip.core.bttn2._y = popupClip.core.bttn1._y;
   popupClip.core.msg._visible = true;
   popupClip.core.bttn1._visible = true;
   popupClip.core.bttn2._visible = true;
}
function chopLoading()
{
   if(tmpLoaded == undefined)
   {
      tmpPreLoaded = 0;
   }
   else
   {
      tmpPreLoaded = tmpLoaded;
   }
   if(mapEngine_Current == "A")
   {
      loadingColor = "blue";
   }
   else if(mapEngine_Current == "B")
   {
      loadingColor = "green";
   }
   else if(mapEngine_Current == "C")
   {
      loadingColor = "pink";
   }
   else
   {
      loadingColor = "orange";
   }
   popupClip.droplet.gotoAndStop(25);
   popupClip.droplet.surface.gotoAndStop(loadingColor);
   popupClip.droplet.fill.gotoAndStop(loadingColor);
}
function showLoading(param)
{
   tmpLoaded = param[0];
   tmpTotal = param[1];
   var _loc1_;
   if(popupClip.droplet._currentframe >= 25)
   {
      _loc1_ = Math.round((tmpLoaded - tmpPreLoaded) / (tmpTotal - tmpPreLoaded) * 100);
      popupClip.droplet.percent.text = _loc1_ + "%";
      popupClip.droplet.percentShadow.text = _loc1_ + "%";
      popupClip.droplet.gotoAndStop(25 + _loc1_);
   }
}
