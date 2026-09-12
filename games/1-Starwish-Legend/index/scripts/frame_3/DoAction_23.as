function initSetting()
{
   var _loc2_ = 0;
   while(_loc2_ <= 2)
   {
      popupClip.core["bttnQ" + _loc2_].id = _loc2_;
      popupClip.core["bttnQ" + _loc2_].onRollOver = function()
      {
         this.gotoAndStop(2);
      };
      popupClip.core["bttnQ" + _loc2_].onRollOut = function()
      {
         this.gotoAndStop(1);
      };
      popupClip.core["bttnQ" + _loc2_].onRelease = function()
      {
         playFx("bob");
         toggleQuality(this.id);
      };
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ <= 1)
   {
      popupClip.core["bttnS" + _loc2_].id = _loc2_;
      popupClip.core["bttnS" + _loc2_].onRollOver = function()
      {
         this.gotoAndStop(2);
      };
      popupClip.core["bttnS" + _loc2_].onRollOut = function()
      {
         this.gotoAndStop(1);
      };
      popupClip.core["bttnS" + _loc2_].onRelease = function()
      {
         playFx("bob");
         toggleWinMode(this.id);
      };
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ <= 3)
   {
      popupClip.core["bttnM" + _loc2_].id = _loc2_;
      popupClip.core["bttnM" + _loc2_].onRollOver = function()
      {
         this.gotoAndStop(2);
      };
      popupClip.core["bttnM" + _loc2_].onRollOut = function()
      {
         this.gotoAndStop(1);
      };
      popupClip.core["bttnM" + _loc2_].onRelease = function()
      {
         playFx("bob");
         toggleMusicVolume(this.id);
      };
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ < 2)
   {
      popupClip.core["bttnd" + _loc2_].id = _loc2_;
      popupClip.core["bttnd" + _loc2_].onRollOver = function()
      {
         this.gotoAndStop(2);
      };
      popupClip.core["bttnd" + _loc2_].onRollOut = function()
      {
         this.gotoAndStop(1);
      };
      popupClip.core["bttnd" + _loc2_].onRelease = function()
      {
         playFx("bob");
         toggleLanguage(this.id);
      };
      _loc2_ = _loc2_ + 1;
   }
   toggleQuality(user.quality);
   toggleWinMode(user.winmode);
   toggleMusicVolume(user.musicvolume);
   toggleLanguage(user.language);
}
function toggleQuality(which)
{
   var _loc1_ = 0;
   while(_loc1_ <= 2)
   {
      if(_loc1_ == which)
      {
         popupClip.core["bttnQ" + _loc1_].gotoAndStop(3);
         popupClip.core["bttnQ" + _loc1_].enabled = false;
      }
      else
      {
         popupClip.core["bttnQ" + _loc1_].gotoAndStop(1);
         popupClip.core["bttnQ" + _loc1_].enabled = true;
      }
      _loc1_ = _loc1_ + 1;
   }
   setUserQuality(which);
}
function setUserQuality(which)
{
   user.quality = which;
   var _loc1_ = ["HIGH","MEDIUM","LOW"];
   _quality = _loc1_[which];
   saveUserData(user);
}
function toggleWinMode(which)
{
   var _loc1_ = 0;
   while(_loc1_ <= 1)
   {
      if(_loc1_ == which)
      {
         popupClip.core["bttnS" + _loc1_].gotoAndStop(3);
         popupClip.core["bttnS" + _loc1_].enabled = false;
      }
      else
      {
         popupClip.core["bttnS" + _loc1_].gotoAndStop(1);
         popupClip.core["bttnS" + _loc1_].enabled = true;
      }
      _loc1_ = _loc1_ + 1;
   }
   setUserWinMode(which);
}
function getUserResolution()
{
   var _loc1_ = mdm.System.getResolution();
   user.oriResX = _loc1_[0];
   user.oriResY = _loc1_[1];
   user.oriColorDepth = _loc1_[2];
   user.oriPosX = mdm.Forms.MainForm.x;
   user.oriPosY = mdm.Forms.MainForm.y;
}
function getCurrentResolution()
{
   var _loc1_ = mdm.System.getResolution();
   currentResX = _loc1_[0];
   currentResY = _loc1_[1];
}
function setUserWinMode(which)
{
   getCurrentResolution();
   if(user.winmode != which)
   {
      if(which == 0)
      {
         if(currentResX != 800 and currentResY != 600)
         {
            mdm.System.DirectX.enable(800,600,user.oriColorDepth);
         }
         mdm.Forms.MainForm.showFullScreen(true);
         mdm.Forms.MainForm.x = 0;
         mdm.Forms.MainForm.y = 0;
      }
      else
      {
         mdm.System.DirectX.disable();
         mdm.Forms.MainForm.x = user.oriPosX;
         mdm.Forms.MainForm.y = user.oriPosY;
      }
      user.winmode = which;
      setBttnDrag();
      saveUserData(user);
   }
}
function toggleMusicVolume(which)
{
   var _loc1_ = 0;
   while(_loc1_ <= 3)
   {
      if(_loc1_ == which)
      {
         popupClip.core["bttnM" + _loc1_].gotoAndStop(3);
         popupClip.core["bttnM" + _loc1_].enabled = false;
      }
      else
      {
         popupClip.core["bttnM" + _loc1_].gotoAndStop(1);
         popupClip.core["bttnM" + _loc1_].enabled = true;
      }
      _loc1_ = _loc1_ + 1;
   }
   setUserMusicVolume(which);
}
function setUserMusicVolume(which)
{
   user.musicvolume = which;
   var _loc2_ = [100,75,50,0];
   _global.music1.setVolume(_loc2_[which]);
   _global.music2.setVolume(_loc2_[which]);
   saveUserData(user);
}
function toggleLanguage(which)
{
   user.language = which;
   var _loc1_ = 0;
   while(_loc1_ < 2)
   {
      if(_loc1_ == which)
      {
         popupClip.core["bttnd" + _loc1_].gotoAndStop(3);
         popupClip.core["bttnd" + _loc1_].enabled = false;
      }
      else
      {
         popupClip.core["bttnd" + _loc1_].gotoAndStop(1);
         popupClip.core["bttnd" + _loc1_].enabled = true;
      }
      _loc1_ = _loc1_ + 1;
   }
   saveUserData(user);
}
