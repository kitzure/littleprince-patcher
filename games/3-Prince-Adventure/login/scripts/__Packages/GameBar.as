class GameBar extends MovieClip
{
   var btnLevel;
   var btnNext;
   var btnRetry;
   var gameScoreField;
   var gameScoreVar;
   var heading;
   var highScoreVar;
   var mcBonus;
   var mcGembox;
   var mc_inst;
   var mc_lv;
   var numAni;
   var numAni2;
   var oldRecord;
   var onEnterFrame;
   var onRelease;
   var onReleaseOutside;
   var onRollOut;
   var onRollOver;
   var score;
   function GameBar()
   {
      super();
      this.gotoAndStop("none");
      Prince3.PrinceSystem.gamebar = this;
   }
   function showLevel(totalLevel)
   {
      this.gotoAndStop("normal");
      var _loc11_ = new flash.geom.ColorTransform(0.4,0.4,0.4,1,0,0,0,0);
      this.mc_inst.mc_title.gotoAndStop(Prince3.PrinceSystem.gameNumber + 1);
      this.mc_inst.mc_ani_box.gotoAndStop(Prince3.PrinceSystem.gameNumber + 1);
      this.mc_inst.mc_ani_box.mc_ani.loadMovie("description/descript" + Prince3.PrinceSystem.gameName + ".swf");
      this.mc_inst.mc_inst_text.gotoAndStop(Prince3.PrinceSystem.gameNumber + 1);
      var _loc9_ = Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber];
      this.mc_lv.gotoAndStop("level" + totalLevel);
      var _loc10_ = 1;
      var _loc5_ = 1;
      var _loc4_;
      var _loc7_;
      var _loc6_;
      var _loc3_;
      var _loc8_;
      while(_loc5_ <= totalLevel)
      {
         _loc4_ = this.mc_lv["mcLevel" + _loc5_];
         _loc4_.gotoAndStop(Prince3.PrinceSystem.gameNumber + 1);
         _loc4_.mcNumber.gotoAndStop(_loc5_);
         _loc7_ = [1,4,3,8,5];
         _loc4_.mcNumber.mcCore.gotoAndStop(_loc7_[Prince3.PrinceSystem.gameArea]);
         _loc4_.descript = _loc9_[_loc5_ - 1].descript;
         _loc6_ = _loc9_[_loc5_ - 1].gems;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            if(_loc6_[_loc3_])
            {
               _loc4_["gem" + _loc3_].gotoAndStop(_loc6_[_loc3_].id + 1);
               _loc4_["no" + _loc3_].gotoAndStop(1);
               _loc4_["no" + _loc3_].no = _loc6_[_loc3_].num;
            }
            else
            {
               _loc4_["gem" + _loc3_].gotoAndStop(1);
               _loc4_["gem" + _loc3_]._visible = false;
               _loc4_["no" + _loc3_].gotoAndStop(1);
               _loc4_["no" + _loc3_]._visible = false;
            }
            _loc3_ = _loc3_ + 1;
         }
         _loc4_.onRelease = function()
         {
            var _loc3_ = 1;
            var _loc2_;
            while(_loc3_ <= 7)
            {
               _loc2_ = this._parent.mc_lv["mcLevel" + _loc3_];
               _loc2_.onRelease = _loc2_.onRollOver = _loc2_.onRollOut = _loc2_.onReleaseOutside = null;
               _loc3_ = _loc3_ + 1;
            }
            Prince3.PrinceSystem.gameInit(int(this._name.substr(7)));
         };
         _loc4_.onRollOver = function()
         {
            this._xscale = this._yscale = 105;
            Prince3.SoundSystem.playSound("sfx/sel" + this._name.substr(7));
            this.gotoAndStop("over");
         };
         _loc4_.onRollOut = _loc4_.onReleaseOutside = function()
         {
            this._xscale = this._yscale = 100;
            this.gotoAndStop(Prince3.PrinceSystem.gameNumber + 1);
         };
         if(_loc5_ > 1)
         {
            _loc7_ = Prince3.PrinceSystem.curUser.gameResult[Prince3.PrinceSystem.gameNumber][_loc5_ - 2];
            if(int(_loc7_[2]) >= Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber][_loc5_ - 2].maxscore && !_root.mc_trial._visible)
            {
               _loc10_ = _loc5_;
            }
            else
            {
               _loc8_ = new flash.geom.Transform(_loc4_);
               _loc8_.colorTransform = _loc11_;
               _loc4_.enabled = false;
            }
         }
         _loc5_ = _loc5_ + 1;
      }
      var _loc13_ = Prince3.PrinceSystem.curUser.gameResult[Prince3.PrinceSystem.gameNumber][_loc10_ - 1];
      if(!_loc13_[3])
      {
         this.mc_lv["mcLevel" + _loc10_].iconNew.gotoAndStop("loop");
      }
      if(_root.mc_trial._visible)
      {
         this.mc_lv.buybox.gotoAndStop(Prince3.PrinceSystem.gameNumber + 1);
      }
      else
      {
         this.mc_lv.buybox.gotoAndStop(1);
         this.mc_lv.buybox._visible = false;
      }
   }
   function showPreload()
   {
      this.gotoAndPlay("leave");
   }
   function showReady()
   {
      this.gotoAndPlay("countdown");
   }
   function replay()
   {
      this.gotoAndStop("preload");
   }
   function preload()
   {
      Prince3.PrinceSystem.miniGamePreload();
   }
   function showReadyEnd()
   {
      Prince3.PrinceSystem.playGame();
   }
   function showGameRelsult(score, pass)
   {
      if(this._currentframe < 38)
      {
         Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,12);
         this.score = score;
         if(pass)
         {
            this.gotoAndPlay("success");
         }
         else
         {
            this.gotoAndPlay("fail");
         }
         Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.btnLeaveGame._visible = false;
         Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.gotoAndStop("ingame");
      }
   }
   function countScore()
   {
      var _loc5_ = Prince3.PrinceSystem.curUser.gameResult[Prince3.PrinceSystem.gameNumber][Prince3.PrinceSystem.gameLevel - 1];
      this.oldRecord = _loc5_[3] ? _loc5_[2] : -1;
      this.stop();
      this.gameScoreVar = "0";
      this.numAni = new Prince3.NumberAni(0,this.score,24);
      this.numAni2 = new Prince3.NumberAni(Prince3.PrinceSystem.curUser.score,Prince3.PrinceSystem.curUser.score + this.score,24);
      this.mcBonus.stop();
      var _loc3_;
      var _loc2_;
      if(this.score >= Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber][Prince3.PrinceSystem.gameLevel - 1].maxscore)
      {
         _loc3_ = Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber][Prince3.PrinceSystem.gameLevel - 1].gems;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            Prince3.PrinceSystem.gemChange(_loc3_[_loc2_].id - 1,_loc3_[_loc2_].num);
            _loc2_ = _loc2_ + 1;
         }
         if(Prince3.PrinceSystem.application.mcFooter.mcCore.exball1._currentframe > 1)
         {
            Prince3.PrinceSystem.gemChange(Prince3.PrinceSystem.application.mcFooter.mcCore.exball1.gem._currentframe - 1,1);
         }
         if(Prince3.PrinceSystem.application.mcFooter.mcCore.exball2._currentframe > 1)
         {
            Prince3.PrinceSystem.gemChange(Prince3.PrinceSystem.application.mcFooter.mcCore.exball2.gem._currentframe - 1,1);
         }
      }
      Prince3.PrinceSystem.scoreChange(this.score);
      Prince3.PrinceSystem.saveGameScore(Prince3.PrinceSystem.gameNumber,Prince3.PrinceSystem.gameLevel,this.score);
      Prince3.PrinceSystem.save();
      this.onEnterFrame = function()
      {
         Prince3.SoundSystem.playSound("sfx/score");
         this.gameScoreVar = int(this.numAni.numberChange());
         var _loc2_ = int(this.numAni2.numberChange());
         if(this.numAni.aniFinish() && this.numAni2.aniFinish())
         {
            Prince3.PrinceSystem.application.mcHeader.setScore(_loc2_,"normal");
            this.onEnterFrame = null;
            this.play();
            trace(">>>> >>>> " + this.oldRecord + "," + this.score);
            if(this.oldRecord != -1 && int(this.oldRecord) < int(this.score) || this.oldRecord == -1 && int(this.score) != 0)
            {
               this.mcBonus._x = this.gameScoreField.textWidth + this.gameScoreField._x + 5;
               this.mcBonus.play();
            }
         }
         else
         {
            Prince3.PrinceSystem.application.mcHeader.setScore(_loc2_,"inc");
         }
      };
   }
   function countTopScore()
   {
      if(this.oldRecord < 0)
      {
         this.highScoreVar = "-";
      }
      else
      {
         this.stop();
         this.highScoreVar = "0";
         this.numAni = new Prince3.NumberAni(0,this.oldRecord,24);
         this.onEnterFrame = function()
         {
            Prince3.SoundSystem.playSound("sfx/score");
            this.highScoreVar = int(this.numAni.numberChange());
            if(this.numAni.aniFinish())
            {
               this.onEnterFrame = null;
               this.play();
            }
         };
      }
   }
   function failEnd()
   {
      Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.btnLeaveGame._visible = true;
      Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.btnLeaveGame.gotoAndPlay(1);
      this.btnRetry.onRelease = function()
      {
         this.onRelease = this.onRollOver = this.onRollOut = this.onReleaseOutside = null;
         Prince3.PrinceSystem.replay();
      };
      this.btnLevel.onRelease = function()
      {
         Prince3.PrinceSystem.backToSelectLevel();
      };
      this.btnRetry.onPress = this.btnLevel.onPress = function()
      {
         this.gotoAndStop("down");
      };
      this.btnRetry.onRollOver = this.btnLevel.onRollOver = function()
      {
         this.gotoAndStop("over");
      };
      this.btnRetry.onRollOut = this.btnRetry.onReleaseOutside = this.btnLevel.onRollOut = this.btnLevel.onReleaseOutside = function()
      {
         this.gotoAndStop("normal");
      };
   }
   function successEnd()
   {
      if(Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber].length == Prince3.PrinceSystem.gameLevel || _root.mc_trial._visible)
      {
         this.btnNext._visible = false;
      }
      this.btnNext.onRelease = function()
      {
         this.onRelease = this.onRollOver = this.onRollOut = this.onReleaseOutside = null;
         Prince3.PrinceSystem.gameLevel++;
         Prince3.PrinceSystem.replay();
      };
      this.btnNext.onPress = function()
      {
         this.gotoAndStop("down");
      };
      this.btnNext.onRollOver = function()
      {
         this.gotoAndStop("over");
      };
      this.btnNext.onRollOut = this.btnNext.onReleaseOutside = function()
      {
         this.gotoAndStop("normal");
      };
      this.failEnd();
   }
   function showgems()
   {
      var _loc4_ = Prince3.PrinceSystem.curMiniGameSetting.gems;
      var _loc5_ = new Array();
      var _loc2_ = 0;
      var _loc3_;
      while(_loc4_[_loc2_])
      {
         _loc3_ = 0;
         while(_loc3_ < _loc4_[_loc2_].num)
         {
            _loc5_.push(_loc4_[_loc2_].id);
            _loc3_ = _loc3_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      trace("showgems " + _loc5_.length);
      this.mcGembox.gotoAndPlay("gem" + _loc5_.length);
      _loc2_ = 0;
      while(_loc2_ < _loc5_.length)
      {
         this.mcGembox["gem" + (_loc2_ + 1)].mcGem.gotoAndStop(_loc5_[_loc2_] + 1);
         this.mcGembox["gem" + (_loc2_ + 1)].onEnterFrame = function()
         {
            var _loc2_;
            if(this._currentframe == this._totalframes)
            {
               this.onEnterFrame = null;
               _loc2_ = this._parent["gem" + (int(this._name.substr(3)) + 1)];
               _loc2_._visible = true;
               _loc2_.play();
            }
         };
         if(_loc2_)
         {
            this.mcGembox["gem" + (_loc2_ + 1)].stop();
            this.mcGembox["gem" + (_loc2_ + 1)]._visible = false;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function showextgems1()
   {
      if(Prince3.PrinceSystem.application.mcFooter.mcCore.exball1._currentframe > 1)
      {
         this.heading.gotoAndPlay("hidden");
         this.mcGembox.exballbg.gotoAndPlay(2);
         this.mcGembox.exballtag.gotoAndPlay(2);
         this.mcGembox.exballtag._x = this.mcGembox.exball1._x - 8;
         this.mcGembox.exball1.gotoAndPlay(2);
         this.mcGembox.exball1.gem.gotoAndStop(Prince3.PrinceSystem.application.mcFooter.mcCore.exball1.gem._currentframe);
         this.mcGembox.exname1.gotoAndStop(this.mcGembox.exball1.gem._currentframe + 1);
         Prince3.PrinceSystem.application.mcFooter.mcCore.exball1.play();
      }
      else
      {
         this.play();
      }
   }
   function showextgems2()
   {
      if(Prince3.PrinceSystem.application.mcFooter.mcCore.exball2._currentframe > 1)
      {
         this.mcGembox.exball2.gotoAndPlay(2);
         this.mcGembox.exball2.gem.gotoAndStop(Prince3.PrinceSystem.application.mcFooter.mcCore.exball2.gem._currentframe);
         this.mcGembox.exballtag._x = this.mcGembox.exball2._x - 8;
         this.mcGembox.exname2.gotoAndStop(this.mcGembox.exball2.gem._currentframe + 1);
         Prince3.PrinceSystem.application.mcFooter.mcCore.exball2.play();
      }
      else
      {
         this.play();
      }
   }
}
