class Header extends MovieClip
{
   var acc;
   var amplitude;
   var btn_card;
   var counter;
   var id;
   var mcBubble;
   var mcPaneL;
   var mcPaneMenu;
   var mcPanePet;
   var mcScore;
   var mov;
   var onEnterFrame;
   var onRelease;
   var onRollOut;
   var onRollOver;
   var side;
   function Header()
   {
      super();
   }
   function onLoad()
   {
      this.mcPanePet._visible = false;
   }
   function showGem()
   {
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < 8)
      {
         _loc3_ = this.mcPaneMenu.gembar.gembar["gem" + _loc2_];
         _loc3_.gotoAndStop(1);
         _loc3_.gem.gotoAndStop(_loc2_ + 1);
         this.mcPaneMenu.gembar.gembar["num" + _loc2_] = Prince3.Utils.num2Str(Prince3.PrinceSystem.curUser.gems[_loc2_],10,1);
         _loc2_ = _loc2_ + 1;
      }
   }
   function showHeader()
   {
      this.mcPaneL.gotoAndPlay("show");
   }
   function hideHeader()
   {
      this.mcPaneMenu.gotoAndStop(1);
      this.mcScore.gotoAndStop(1);
      this.mcPaneL.gotoAndStop(1);
      this.mcPanePet.gotoAndStop(1);
   }
   function setScore(num, type)
   {
      var _loc5_;
      if(type == "normal")
      {
         _loc5_ = 1;
      }
      else if(type == "dec")
      {
         _loc5_ = 2;
      }
      else if(type == "inc")
      {
         _loc5_ = 3;
      }
      var _loc6_ = Prince3.Utils.num2Str(Prince3.Utils.numLimit(num,0,9999999),10,1);
      var _loc3_ = 1;
      var _loc2_;
      while(_loc3_ <= 7)
      {
         num = Number(_loc6_.substr(_loc3_ - 1,1)) + 1;
         _loc2_ = this.mcScore["mcNum" + _loc3_];
         if(_loc3_ <= _loc6_.length)
         {
            _loc2_.gotoAndStop(num);
            _loc2_.mcCore.gotoAndStop(_loc5_);
            _loc2_._visible = true;
         }
         else
         {
            _loc2_.gotoAndStop(1);
            _loc2_.mcCore.gotoAndStop(_loc5_);
            _loc2_._visible = false;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function initNum()
   {
      this.mcScore.gotoAndStop(2);
      this.setScore(Prince3.PrinceSystem.curUser.score,"normal");
   }
   function initPaneLBtn()
   {
      this.mcPaneL.btnItem.onRollOver = this.mcPaneL.btnCrown.onRollOver = this.mcPaneL.btnReport.onRollOver = function()
      {
         this.mcBubble.gotoAndStop(2);
         this._parent.over = true;
         this.gotoAndPlay("over");
         this._parent._parent.showHint(this._name);
      };
      this.mcPaneL.btnItem.onRollOut = this.mcPaneL.btnCrown.onRollOut = this.mcPaneL.btnReport.onRollOut = function()
      {
         this.mcBubble.gotoAndStop(1);
         this._parent.over = false;
         this.gotoAndStop("normal");
         this._parent._parent.killHint();
      };
      this.mcPaneL.btnItem.onPress = this.mcPaneL.btnCrown.onPress = this.mcPaneL.btnReport.onPress = function()
      {
         delete this.onRollOver;
         delete this.onRollOut;
         delete this.onRelease;
         delete this.mcPaneL.btnItem.onEnterFrame;
         delete this.mcPaneL.btnCrown.onEnterFrame;
         delete this.mcPaneL.btnReport.onEnterFrame;
         this.gotoAndPlay("fall");
         this._parent._parent.killHint();
      };
   }
   function showHint(pmHint)
   {
      Prince3.PrinceSystem.showHint(pmHint);
   }
   function killHint()
   {
      Prince3.PrinceSystem.showHint();
   }
   function initWind(pmBase, pmBtn)
   {
      var _loc2_ = 1;
      while(_loc2_ <= 3)
      {
         pmBase[pmBtn[_loc2_ - 1]].counter = random(10) / 3;
         pmBase[pmBtn[_loc2_ - 1]].amplitude = random(5) + 5;
         pmBase[pmBtn[_loc2_ - 1]].side = random(2) != 1 ? -1 : 1;
         pmBase[pmBtn[_loc2_ - 1]].onEnterFrame = function()
         {
            if(!this._parent.over)
            {
               this.counter += 0.2;
               this.amplitude += 0.2;
               this.mov = Math.sin(this.amplitude) * 3;
               this._rotation = this.side * Math.sin(this.counter) * this.mov;
            }
         };
         _loc2_ = _loc2_ + 1;
      }
   }
   function showOtherPane()
   {
      this.mcPanePet.gotoAndPlay("enter");
      this.mcPaneMenu.gotoAndPlay("enter");
   }
   function initMenu()
   {
      this.mcPaneMenu.mcCore.onRollOver = function()
      {
         this.gotoAndPlay("over");
         this._parent._parent.showHint("menu");
         Prince3.SoundSystem.playSound("sfx/drag");
      };
      this.mcPaneMenu.mcCore.onRollOut = function()
      {
         this.gotoAndStop(11);
         this._parent._parent.killHint();
      };
      this.mcPaneMenu.mcCore.onRelease = function()
      {
         Prince3.PrinceSystem.pause = true;
         Prince3.PrinceSystem.blurBG();
         this._parent._parent.showMenu();
         Prince3.SoundSystem.playSound("sfx/drop");
      };
      delete this.mcPaneL.over;
      this.mcPaneMenu.btn_card.onRollOver = function()
      {
         this.gotoAndPlay("over");
         this._parent._parent.showHint("card");
         Prince3.SoundSystem.playSound("sfx/drag");
      };
      this.mcPaneMenu.btn_card.onRollOut = this.btn_card.onReleaseOutside = function()
      {
         this.gotoAndStop(11);
         this._parent._parent.killHint();
      };
      this.mcPaneMenu.btn_card.onRelease = function()
      {
         this._parent._parent.killHint();
         this._parent._parent.prepareGame();
         Prince3.SoundSystem.playSound("sfx/drop");
      };
   }
   function initMenuCore()
   {
      var _loc3_ = ["btnSetting","btnHelp","btnExit","showSetting","showHelp","showExit"];
      var _loc2_ = 0;
      var _loc4_;
      while(_loc2_ < 3)
      {
         _loc4_ = this.mcPaneMenu[_loc3_[_loc2_]];
         _loc4_.id = _loc2_ + 1;
         _loc4_.f = _loc3_[_loc2_ + 3];
         _loc4_.onRollOver = function()
         {
            this.gotoAndPlay("over");
            this._parent["mcTag" + this.id].gotoAndStop(2);
            Prince3.SoundSystem.playSound("sfx/drag");
         };
         _loc4_.onRollOut = function()
         {
            this.gotoAndPlay("out");
            this._parent["mcTag" + this.id].gotoAndStop(1);
         };
         _loc4_.onRelease = function()
         {
            this._parent._parent[this.f]();
         };
         _loc2_ = _loc2_ + 1;
      }
      _loc4_ = this.mcPaneMenu.mcCore;
      _loc4_.onRollOver = function()
      {
         this._parent._parent.showHint("leaveMenu");
         this.gotoAndPlay("over");
         Prince3.SoundSystem.playSound("sfx/drag");
      };
      _loc4_.onRollOut = function()
      {
         this._parent._parent.killHint();
         this.gotoAndStop(22);
      };
      _loc4_.onRelease = function()
      {
         this._parent._parent.killHint();
         this._parent.gotoAndPlay("out");
         this.enabled = false;
         this.gotoAndPlay("fall");
      };
   }
   function showMenu()
   {
      this.killHint();
      this.mcPaneMenu.gotoAndPlay("open1");
      this.mcPaneL.over = true;
   }
   function showSetting()
   {
      this.mcPaneMenu.mcCore.onRelease = function()
      {
         this._parent._parent.killHint();
         this._parent.toGo = "normal";
         this._parent.gotoAndPlay("sOut");
         this.enabled = false;
         this.gotoAndPlay("fall");
      };
      this.mcPaneMenu.btnSetting.enabled = false;
      this.mcPaneMenu.gotoAndPlay("setting");
      this.mcPaneMenu.btnSetting2.gotoAndPlay("select");
   }
   function showHelp()
   {
      this.mcPaneMenu.mcCore.onRelease = function()
      {
         this._parent._parent.killHint();
         this._parent.toGo = "normal";
         this._parent.gotoAndPlay("hOut");
         this.enabled = false;
         this.gotoAndPlay("fall");
      };
      this.mcPaneMenu.btnHelp.enabled = false;
      this.mcPaneMenu.gotoAndPlay("help");
      this.mcPaneMenu.btnHelp2.gotoAndPlay("select");
   }
   function showExit()
   {
      this.mcPaneMenu.mcCore.onRelease = function()
      {
         this._parent._parent.killHint();
         this._parent.toGo = "normal";
         this._parent.gotoAndPlay("eOut");
         this.enabled = false;
         this.gotoAndPlay("fall");
      };
      this.mcPaneMenu.btnExit.enabled = false;
      this.mcPaneMenu.gotoAndPlay("exit");
      this.mcPaneMenu.btnExit2.gotoAndPlay("select");
   }
   function initBtnResult()
   {
      this.mcPaneMenu.btnGetResult.onRollOver = function()
      {
         this._parent._parent.showHint("result");
         this.gotoAndPlay("over");
      };
      this.mcPaneMenu.btnGetResult.onRollOut = function()
      {
         this._parent._parent.killHint();
         this.gotoAndStop("normal");
      };
      this.mcPaneMenu.btnGetResult.onRelease = function()
      {
         this._parent._parent.killHint();
         delete this.onRollOver;
         delete this.onRollOut;
         this.gotoAndPlay("fall");
         if(Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber][Prince3.PrinceSystem.gameLevel - 1].type == "timer")
         {
            Prince3.PrinceSystem.game.timeupCallBack();
         }
         else
         {
            Prince3.PrinceSystem.game.reduceChanceCallBack();
         }
      };
   }
   function initBtnLeave()
   {
      this.mcPaneMenu.btnLeaveGame.onRollOver = function()
      {
         this._parent._parent.showHint("leaveGame");
         this.gotoAndPlay("over");
      };
      this.mcPaneMenu.btnLeaveGame.onRollOut = function()
      {
         this._parent._parent.killHint();
         this.gotoAndStop("normal");
      };
      this.mcPaneMenu.btnLeaveGame.onRelease = function()
      {
         if(!Prince3.PrinceSystem.application.loading._visible)
         {
            if(Prince3.PrinceSystem.status == "buy card")
            {
               if(!Prince3.PrinceSystem.canCloseBuyCard())
               {
                  return undefined;
               }
               Prince3.PrinceSystem.application.gamebar.buycard.gotoAndStop("end");
            }
            this._parent._parent.killHint();
            delete this.onRollOver;
            delete this.onRollOut;
            this.gotoAndPlay("fall");
            if(Prince3.PrinceSystem.status == "game" && this._parent.mcGameTag)
            {
               return undefined;
            }
            if(this._parent.btnGameHelp._currentframe != 40)
            {
               this._parent.btnGameHelp.gotoAndPlay("leave");
            }
            this._parent.mcGameTag.gotoAndPlay("leave");
            if(this._parent.mcGameInst._currentframe != 1)
            {
               this._parent.mcGameInst.gotoAndPlay("leave");
            }
         }
      };
   }
   function initBtnHelp()
   {
      this.mcPaneMenu.btnGameHelp.onRollOver = function()
      {
         this._parent._parent.showHint("help");
         this.gotoAndPlay("over");
      };
      this.mcPaneMenu.btnGameHelp.onRollOut = function()
      {
         this._parent._parent.killHint();
         this.gotoAndStop("normal");
      };
      this.mcPaneMenu.btnGameHelp.onRelease = function()
      {
         this._parent._parent.killHint();
         delete this.onRollOver;
         delete this.onRollOut;
         this.gotoAndPlay("fall");
         this._parent.mcGameTag.acc = 7;
         this._parent.mcGameTag.onEnterFrame = function()
         {
            if(this._x > 285)
            {
               this._x -= this.acc;
               this.acc += this.acc;
               if(this._x <= 285)
               {
                  this._x = 285;
                  this.onEnterFrame = null;
               }
            }
         };
      };
   }
   function showGameHelp()
   {
      this.mcPaneMenu.mcGameInst.gotoAndPlay("enter");
   }
   function prepareGame()
   {
      this.mcPaneMenu.gotoAndPlay("prepareGame");
      this.mcPaneL.btnItem.gotoAndPlay("fall");
      this.mcPaneL.btnCrown.gotoAndPlay("fall");
      this.mcPaneL.btnReport.gotoAndPlay("fall");
      this.mcPanePet.gotoAndPlay("leave");
   }
   function prepareGame2()
   {
      this.mcPaneMenu.gotoAndPlay("prepareGame2");
      this.mcPaneL.btnItem.gotoAndPlay("fall");
      this.mcPaneL.btnCrown.gotoAndPlay("fall");
      this.mcPaneL.btnReport.gotoAndPlay("fall");
      this.mcPanePet.gotoAndPlay("leave");
   }
   function switchGame()
   {
      this.mcPaneMenu.gotoAndPlay("toGame");
   }
   function switchInGame()
   {
      this.mcPaneMenu.gotoAndPlay("inGame");
      this.mcPaneMenu.mcGameTag._x = 512;
      this.mcPaneMenu.mcGameTag.mcCore.gotoAndStop(Prince3.PrinceSystem.gameNumber + 1);
      this.mcPaneMenu.mcGameTag.mcCore.mc_number.gotoAndStop(Prince3.PrinceSystem.gameLevel + 1);
      var _loc2_ = [1,3,5,7,4];
      this.mcPaneMenu.mcGameTag.mcCore.mc_number.mcCore.gotoAndStop(_loc2_[Prince3.PrinceSystem.gameArea]);
      this.mcPaneMenu.mcGameInst.mcCore.gotoAndStop(Prince3.PrinceSystem.gameNumber + 1);
      this.mcPaneMenu.mcGameInst.onRelease = function()
      {
         this.gotoAndPlay("leave");
         this._parent.mcGameTag.acc = 7;
         this._parent.mcGameTag.onEnterFrame = function()
         {
            if(this._x < 512)
            {
               this._x += this.acc;
               this.acc += this.acc;
               if(this._x >= 512)
               {
                  this._x = 512;
                  this.onEnterFrame = null;
                  this._parent._parent.initBtnHelp();
               }
            }
         };
         this._parent.btnGameHelp.gotoAndPlay("enter");
      };
   }
   function exitPopup()
   {
      var _loc2_ = this.mcPaneMenu.btnYes;
      var _loc4_ = this.mcPaneMenu.btnNo;
      var _loc3_ = this.mcPaneMenu.btnLevel;
      _loc2_.onRollOut = _loc2_.onReleaseOutside = _loc4_.onRollOut = _loc4_.onReleaseOutside = _loc3_.onRollOut = _loc3_.onReleaseOutside = function()
      {
         this.gotoAndStop("normal");
      };
      _loc2_.onRollOver = _loc4_.onRollOver = _loc3_.onRollOver = function()
      {
         this.gotoAndStop("over");
      };
      _loc2_.onPress = _loc4_.onPress = _loc3_.onPress = function()
      {
         this.gotoAndStop("down");
      };
      _loc2_.onRelease = function()
      {
         this._parent.gotoAndStop("request_exit_end");
         Prince3.PrinceSystem.loadMap();
      };
      _loc4_.onRelease = function()
      {
         this._parent.btnLeaveGame.play();
         this._parent._parent.initBtnLeave();
         this._parent.gotoAndStop("ingame");
      };
      _loc3_.onRelease = function()
      {
         Prince3.PrinceSystem.exitGameToSelectLevel();
      };
   }
   function switchMenu()
   {
      if(Prince3.PrinceSystem.status != "buy card")
      {
         if(Prince3.PrinceSystem.status == "game" && this.mcPaneMenu.mcGameTag)
         {
            if(Prince3.PrinceSystem.gamebar._currentframe != 1)
            {
               Prince3.PrinceSystem.loadMap();
            }
            else
            {
               this.mcPaneMenu.gotoAndPlay("request_exit");
            }
            return undefined;
         }
         if(Prince3.PrinceSystem.status == "game select menu" || Prince3.PrinceSystem.status == "prebattle")
         {
            Prince3.PrinceSystem.closeGameSelectMenu();
         }
         else
         {
            Prince3.PrinceSystem.loadMap();
         }
         this.mcPaneL.btnItem.gotoAndPlay("enter");
         this.mcPaneL.btnCrown.gotoAndPlay("enter");
         this.mcPaneL.btnReport.gotoAndPlay("enter");
      }
   }
   function switchBacktoGame()
   {
      this.mcPaneMenu.play();
      if(this.mcPaneMenu.btnGameHelp._currentframe != 40)
      {
         this.mcPaneMenu.btnGameHelp.gotoAndPlay("leave");
      }
      this.mcPaneMenu.mcGameTag.gotoAndPlay("leave");
      if(this.mcPaneMenu.mcGameInst._currentframe != 1)
      {
         this.mcPaneMenu.mcGameInst.gotoAndPlay("leave");
      }
   }
   function settingInit()
   {
      Prince3.PrinceSystem.save();
      trace("settingInit");
      var _loc5_ = ["低","中","高"];
      var _loc4_ = 0;
      var _loc7_;
      while(_loc4_ < 3)
      {
         _loc7_ = this.mcPaneMenu.mcSetting["btn_q" + _loc4_];
         _loc7_.gotoAndStop(1);
         _loc7_.txt = _loc5_[_loc4_];
         _loc7_.onRollOver = function()
         {
            Prince3.SoundSystem.playSound("sfx/drag");
            this.gotoAndStop(3);
         };
         _loc7_.onRollOut = _loc7_.onReleaseOutside = function()
         {
            this.gotoAndStop(1);
         };
         _loc7_.onRelease = function()
         {
            Prince3.SoundSystem.playSound("sfx/bob");
            trace(this._name.substr(5) + "," + this._parent._parent);
            var _loc3_ = int(this._name.substr(5));
            Prince3.PrinceSystem.settingChange("screen_quality",_loc3_);
            if(_loc3_ == 0)
            {
               _root._quality = "LOW";
            }
            else if(_loc3_ == 1)
            {
               _root._quality = "MEDIUM";
            }
            else if(_loc3_ == 2)
            {
               _root._quality = "HIGH";
            }
            this._parent._parent._parent.settingInit();
         };
         _loc4_ = _loc4_ + 1;
      }
      _loc7_ = this.mcPaneMenu.mcSetting["btn_q" + Prince3.PrinceSystem.curUser.screen_quality];
      _loc7_.gotoAndStop(2);
      delete _loc7_.onRollOver;
      delete _loc7_.onRollOut;
      delete _loc7_.onReleaseOutside;
      delete _loc7_.onRelease;
      _loc5_ = ["視窗","全螢幕"];
      _loc4_ = 0;
      while(_loc4_ < 2)
      {
         _loc7_ = this.mcPaneMenu.mcSetting["btn_f" + _loc4_];
         _loc7_.gotoAndStop(1);
         _loc7_.txt = _loc5_[_loc4_];
         _loc7_.onRollOver = function()
         {
            Prince3.SoundSystem.playSound("sfx/drag");
            this.gotoAndStop(3);
         };
         _loc7_.onRollOut = _loc7_.onReleaseOutside = function()
         {
            this.gotoAndStop(1);
         };
         _loc7_.onRelease = function()
         {
            Prince3.SoundSystem.playSound("sfx/bob");
            if(this._name.substr(5) == 0)
            {
               _root.applicationWindowMode();
            }
            else
            {
               _root.applicationFullScreenMode();
            }
            Prince3.PrinceSystem.settingChange("fullscreen",this._name.substr(5));
            this._parent._parent._parent.settingInit();
         };
         _loc4_ = _loc4_ + 1;
      }
      _loc7_ = this.mcPaneMenu.mcSetting["btn_f" + Prince3.PrinceSystem.curUser.fullscreen];
      _loc7_.gotoAndStop(2);
      delete _loc7_.onRollOver;
      delete _loc7_.onRollOut;
      delete _loc7_.onReleaseOutside;
      delete _loc7_.onRelease;
      _loc5_ = ["無","小","中","大"];
      _loc4_ = 0;
      while(_loc4_ < 4)
      {
         _loc7_ = this.mcPaneMenu.mcSetting["btn_s" + _loc4_];
         _loc7_.gotoAndStop(1);
         _loc7_.txt = _loc5_[_loc4_];
         _loc7_.onRollOver = function()
         {
            Prince3.SoundSystem.playSound("sfx/drag");
            this.gotoAndStop(3);
         };
         _loc7_.onRollOut = _loc7_.onReleaseOutside = function()
         {
            this.gotoAndStop(1);
         };
         _loc7_.onRelease = function()
         {
            Prince3.SoundSystem.playSound("sfx/bob");
            Prince3.PrinceSystem.settingChange("sound_level",this._name.substr(5));
            var _loc2_ = [0,33,66,100];
            Prince3.SoundSystem.maxVal = _loc2_[Prince3.PrinceSystem.curUser.sound_level];
            Prince3.SoundSystem.setVolume(Prince3.SoundSystem.maxVal);
            this._parent._parent._parent.settingInit();
         };
         _loc4_ = _loc4_ + 1;
      }
      _loc7_ = this.mcPaneMenu.mcSetting["btn_s" + Prince3.PrinceSystem.curUser.sound_level];
      _loc7_.gotoAndStop(2);
      delete _loc7_.onRollOver;
      delete _loc7_.onRollOut;
      delete _loc7_.onReleaseOutside;
      delete _loc7_.onRelease;
      _loc5_ = ["粵語","普通話"];
      _loc4_ = 0;
      while(_loc4_ < 2)
      {
         _loc7_ = this.mcPaneMenu.mcSetting["btn_lang" + _loc4_];
         _loc7_.gotoAndStop(1);
         _loc7_.txt = _loc5_[_loc4_];
         _loc7_.onRollOver = function()
         {
            Prince3.SoundSystem.playSound("sfx/drag");
            this.gotoAndStop(3);
         };
         _loc7_.onRollOut = _loc7_.onReleaseOutside = function()
         {
            this.gotoAndStop(1);
         };
         _loc7_.onRelease = function()
         {
            Prince3.SoundSystem.playSound("sfx/bob");
            Prince3.PrinceSystem.settingChange("language",this._name.substr(8));
            this._parent._parent._parent.settingInit();
         };
         _loc4_ = _loc4_ + 1;
      }
      _loc7_ = this.mcPaneMenu.mcSetting["btn_lang" + Prince3.PrinceSystem.curUser.language];
      _loc7_.gotoAndStop(2);
      delete _loc7_.onRollOver;
      delete _loc7_.onRollOut;
      delete _loc7_.onReleaseOutside;
      delete _loc7_.onRelease;
   }
   function exitInit()
   {
      var _loc3_ = this.mcPaneMenu.mcHelp;
      _loc3_.btn_logout.isCheckButton = false;
      _loc3_.btn_logout.onSelect = function()
      {
         Prince3.PrinceSystem.reset();
      };
      _loc3_.btn_exit.isCheckButton = false;
      _loc3_.btn_exit.onSelect = function()
      {
         _root.applicationClose();
      };
   }
}
