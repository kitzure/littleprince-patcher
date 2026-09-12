class Prince3.PrinceSystem
{
   static var application;
   static var backFromGame;
   static var boss;
   static var cardInfo;
   static var cardSetting;
   static var cheatCode;
   static var curBGM;
   static var curMiniGameSetting;
   static var curUser;
   static var game;
   static var gameArea;
   static var gameLevel;
   static var gameName;
   static var gameNumber;
   static var gamebar;
   static var kctrl;
   static var kctrl2;
   static var keyListener;
   static var lastx;
   static var lasty;
   static var mapRecord;
   static var mctrl;
   static var miniGameSetting;
   static var mode;
   static var online;
   static var princeService_nc;
   static var status;
   static var updateList;
   static var users;
   static var __princeSystem = new Prince3.PrinceSystem();
   static var pause = false;
   function PrinceSystem()
   {
      trace("PrinceSystem init");
      Prince3.PrinceSystem.mode = "normal";
      Prince3.PrinceSystem.online = _root._url.indexOf("http://") != -1;
      MovieClip.prototype.useHandCursor = false;
      Button.prototype.useHandCursor = false;
      Prince3.PrinceSystem.keyListener = new Object();
      Prince3.PrinceSystem.keyListener.onKeyDown = function()
      {
         Prince3.PrinceSystem.onKeyDown();
      };
      trace("Key.addListener");
      Key.addListener(Prince3.PrinceSystem.keyListener);
      Prince3.PrinceSystem.cheatCode = "";
      Prince3.PrinceSystem.updateList = new Object();
   }
   static function onKeyDown()
   {
      var _loc3_;
      var _loc2_;
      var _loc1_;
      if(Prince3.PrinceSystem.status == "map" && Prince3.PrinceSystem.pause == false)
      {
         Prince3.PrinceSystem.cheatCode += chr(Key.getAscii());
         if("solomon@score".indexOf(Prince3.PrinceSystem.cheatCode) == 0)
         {
            if("solomon@score".length == Prince3.PrinceSystem.cheatCode.length)
            {
               Prince3.SoundSystem.playSound("sfx/ding");
               Prince3.PrinceSystem.scoreChange(2000);
               Prince3.PrinceSystem.application.mcHeader.setScore(Prince3.PrinceSystem.curUser.score,"normal");
               Prince3.PrinceSystem.save();
               Prince3.PrinceSystem.cheatCode = "";
            }
         }
         else if("solomon@gem".indexOf(Prince3.PrinceSystem.cheatCode) == 0)
         {
            if("solomon@gem".length == Prince3.PrinceSystem.cheatCode.length)
            {
               Prince3.SoundSystem.playSound("sfx/ding");
               _loc3_ = 0;
               while(_loc3_ < 8)
               {
                  Prince3.PrinceSystem.gemChange(_loc3_,10);
                  _loc3_ = _loc3_ + 1;
               }
               Prince3.PrinceSystem.save();
               Prince3.PrinceSystem.application.mcHeader.showGem();
               Prince3.PrinceSystem.cheatCode = "";
            }
         }
         else if("solomonbrain".indexOf(Prince3.PrinceSystem.cheatCode) == 0)
         {
            if("solomonbrain".length == Prince3.PrinceSystem.cheatCode.length)
            {
               Prince3.SoundSystem.playSound("sfx/ding");
               _loc3_ = 0;
               while(_loc3_ < 84)
               {
                  Prince3.PrinceSystem.setCard(_loc3_);
                  _loc3_ = _loc3_ + 1;
               }
               Prince3.PrinceSystem.save();
               Prince3.PrinceSystem.cheatCode = "";
            }
         }
         else if("solomoncollector".indexOf(Prince3.PrinceSystem.cheatCode) == 0)
         {
            if("solomoncollector".length == Prince3.PrinceSystem.cheatCode.length)
            {
               Prince3.SoundSystem.playSound("sfx/ding");
               _loc3_ = 1;
               while(_loc3_ < 28)
               {
                  Prince3.PrinceSystem.gameCardChange(_loc3_,1);
                  _loc3_ = _loc3_ + 1;
               }
               Prince3.PrinceSystem.save();
               Prince3.PrinceSystem.cheatCode = "";
            }
         }
         else if("solomonopendoor".indexOf(Prince3.PrinceSystem.cheatCode) == 0)
         {
            if("solomonopendoor".length == Prince3.PrinceSystem.cheatCode.length)
            {
               Prince3.SoundSystem.playSound("sfx/ding");
               _loc2_ = 0;
               while(_loc2_ < Prince3.PrinceSystem.miniGameSetting.length)
               {
                  _loc1_ = 0;
                  while(_loc1_ < Prince3.PrinceSystem.miniGameSetting[_loc2_].length - 1)
                  {
                     Prince3.PrinceSystem.saveGameScore(_loc2_,_loc1_ + 1,Prince3.PrinceSystem.miniGameSetting[_loc2_][_loc1_].maxscore);
                     _loc1_ = _loc1_ + 1;
                  }
                  _loc2_ = _loc2_ + 1;
               }
               Prince3.PrinceSystem.save();
               Prince3.PrinceSystem.cheatCode = "";
            }
         }
         else
         {
            Prince3.PrinceSystem.cheatCode = "";
         }
      }
      if(Prince3.PrinceSystem.kctrl2 && !(Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe >= 178 && Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe <= 188))
      {
         Prince3.PrinceSystem.kctrl2.onKeyDownEvent();
      }
   }
   static function setKeyCtrl(target, keyCfg)
   {
      Prince3.PrinceSystem.kctrl = new Prince3.KeyController(target,keyCfg);
   }
   static function setKeyCtrl2(target)
   {
      Prince3.PrinceSystem.kctrl2 = target;
   }
   static function keyUpdate()
   {
      if(Prince3.PrinceSystem.kctrl && !(Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe >= 178 && Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe <= 188))
      {
         Prince3.PrinceSystem.kctrl.run();
      }
   }
   static function setMouseCtrl(target)
   {
      Prince3.PrinceSystem.mctrl = target;
   }
   static function onMouseUp()
   {
      if(Prince3.PrinceSystem.mctrl && Prince3.PrinceSystem.inGameQuitMenu())
      {
         Prince3.PrinceSystem.lastx = _root._xmouse;
         Prince3.PrinceSystem.lasty = _root._ymouse;
         Prince3.PrinceSystem.mctrl.onMouseUpEvent(_root._xmouse,_root._ymouse);
      }
   }
   static function onMouseDown()
   {
      trace(">>>>mouse down");
      if(Prince3.PrinceSystem.mctrl && Prince3.PrinceSystem.inGameQuitMenu())
      {
         Prince3.PrinceSystem.lastx = _root._xmouse;
         Prince3.PrinceSystem.lasty = _root._ymouse;
         Prince3.PrinceSystem.mctrl.onMouseDownEvent(_root._xmouse,_root._ymouse);
      }
   }
   static function onMouseMove()
   {
      if(Prince3.PrinceSystem.mctrl && !(Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe >= 178 && Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe <= 188))
      {
         Prince3.PrinceSystem.lastx = _root._xmouse;
         Prince3.PrinceSystem.lasty = _root._ymouse;
         Prince3.PrinceSystem.mctrl.onMouseMoveEvent(_root._xmouse,_root._ymouse);
      }
   }
   static function random(num)
   {
      return int(Math.random() * num);
   }
   static function actionCapture(obj, eventName)
   {
      if(Prince3.PrinceSystem.mode == "capture")
      {
      }
   }
   static function inGameQuitMenu()
   {
      return !(Prince3.PrinceSystem.status == "game" && Prince3.PrinceSystem.application.mcHeader.hitTest(_root._xmouse,_root._ymouse,true)) && !(Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe >= 178 && Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe <= 188);
   }
   static function notInGameQuitMenu()
   {
      return !(Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe >= 178 && Prince3.PrinceSystem.application.mcHeader.mcPaneMenu._currentframe <= 188);
   }
   static function serviceRequest(data)
   {
      var _loc2_ = new Object();
      _loc2_.onResult = Prince3.PrinceSystem.serviceResponse;
      Prince3.PrinceSystem.princeService_nc = new NetConnection();
      if(_root.haveNetwork())
      {
         Prince3.PrinceSystem.princeService_nc.connect("http://www.little-prince.com.hk/littleprince/amfservice/gateway.php");
         Prince3.PrinceSystem.princeService_nc.call("Prince3.serviceRequest",_loc2_,data);
         return true;
      }
      return false;
   }
   static function serviceResponse(val)
   {
      var _loc10_;
      var _loc6_;
      var _loc4_;
      var _loc2_;
      var _loc9_;
      var _loc7_;
      var _loc11_;
      var _loc5_;
      var _loc3_;
      var _loc12_;
      if(val)
      {
         trace("serviceResponse: " + val.response);
         if(val.response == "checkVersionResult")
         {
            Prince3.PrinceSystem.application.checkVersionResponse(val.message);
         }
         else if(val.response == "activationResult")
         {
            Prince3.PrinceSystem.application.activationResponse(val.message);
         }
         else if(val.response == "reactivationResult")
         {
            Prince3.PrinceSystem.application.reactivationResponse(val.message);
         }
         else if(val.response == "checkActivationResult")
         {
            Prince3.PrinceSystem.application.checkActivationResponse(val.message);
         }
         else if(val.response == "loginFail")
         {
            flash.external.ExternalInterface.call("alert",val.message);
         }
         else if(val.response == "requestFail")
         {
            flash.external.ExternalInterface.call("alert",val.message);
            Prince3.PrinceSystem.reset();
         }
         else if(val.response != "requestSuccess")
         {
            if(val.response == "getRank")
            {
               _loc10_ = [val.score_rank,val.star_rank,val.equip_rank];
               _loc6_ = 0;
               while(_loc6_ < 3)
               {
                  _loc4_ = 0;
                  while(_loc10_[_loc6_][_loc4_])
                  {
                     _loc2_ = _loc10_[_loc6_][_loc4_];
                     _loc2_.userName = _loc2_[0];
                     _loc2_.sex = _loc2_[1];
                     _loc2_.schoolName = _loc2_[2];
                     _loc2_.classLv = _loc2_[3];
                     _loc2_.className = _loc2_[4];
                     _loc2_.score = _loc2_[5];
                     _loc2_.gems = Prince3.Utils.str2nArray(_loc2_[6],",");
                     _loc9_ = 0;
                     while(_loc9_ < _loc2_.gems.length)
                     {
                        _loc2_.gems[_loc9_] = int(_loc2_.gems[_loc9_]);
                        _loc9_ = _loc9_ + 1;
                     }
                     _loc2_.items = Prince3.Utils.str2nArray(_loc2_[7],",");
                     _loc9_ = 0;
                     while(_loc9_ < _loc2_.items.length)
                     {
                        _loc2_.items[_loc9_] = int(_loc2_.items[_loc9_]);
                        _loc9_ = _loc9_ + 1;
                     }
                     _loc2_.cards = Prince3.Utils.str2nArray(_loc2_[8],",");
                     _loc9_ = 0;
                     while(_loc9_ < _loc2_.cards.length)
                     {
                        _loc2_.cards[_loc9_] = int(_loc2_.cards[_loc9_]);
                        _loc9_ = _loc9_ + 1;
                     }
                     _loc2_.t_star = _loc2_[9];
                     _loc2_.t_weapon = _loc2_[10];
                     _loc2_.t_card = _loc2_[11];
                     _loc2_.t_item = _loc2_.t_card + _loc2_.t_weapon;
                     _loc4_ = _loc4_ + 1;
                  }
                  _loc6_ = _loc6_ + 1;
               }
               Prince3.PrinceSystem.application.content.mcPop.myRank.updateTopRankView(val.score_rank,val.star_rank,val.equip_rank);
               Prince3.PrinceSystem.application.content.mcPop.myRank.updateRankView(0);
            }
            else if(val.response == "loginSuccess")
            {
               Prince3.PrinceSystem.curUser = new Prince3.User();
               Prince3.PrinceSystem.curUser.loginName = val.loginName;
               Prince3.PrinceSystem.curUser.userName = val.name;
               Prince3.PrinceSystem.curUser.sex = int(val.sex);
               Prince3.PrinceSystem.curUser.schoolName = val.schoolName;
               Prince3.PrinceSystem.curUser.schoolType = int(val.schoolType);
               Prince3.PrinceSystem.curUser.classLv = int(val.classLv);
               Prince3.PrinceSystem.curUser.className = val.className;
               Prince3.PrinceSystem.curUser.screen_quality = int(val.screen_quality);
               Prince3.PrinceSystem.curUser.fullscreen = int(val.fullscreen);
               Stage.displayState = Prince3.PrinceSystem.curUser.fullscreen != 1 ? "normal" : "fullScreen";
               Prince3.PrinceSystem.curUser.sound_level = int(val.sound_level);
               Prince3.PrinceSystem.curUser.language = int(val.language);
               Prince3.PrinceSystem.curUser.score = int(val.score);
               Prince3.PrinceSystem.curUser.gems = Prince3.Utils.str2nArray(val.gems,",");
               _loc9_ = 0;
               while(_loc9_ < Prince3.PrinceSystem.curUser.gems.length)
               {
                  Prince3.PrinceSystem.curUser.gems[_loc9_] = int(Prince3.PrinceSystem.curUser.gems[_loc9_]);
                  _loc9_ = _loc9_ + 1;
               }
               Prince3.PrinceSystem.curUser.cards = Prince3.Utils.str2nArray(val.cards,",");
               _loc9_ = 0;
               while(_loc9_ < Prince3.PrinceSystem.curUser.cards.length)
               {
                  Prince3.PrinceSystem.curUser.cards[_loc9_] = int(Prince3.PrinceSystem.curUser.cards[_loc9_]);
                  _loc9_ = _loc9_ + 1;
               }
               trace("login success");
               Prince3.PrinceSystem.curUser.gameResult = val.gameResult;
               _loc7_ = 0;
               while(_loc7_ < Prince3.PrinceSystem.curUser.gameResult.length)
               {
                  _loc11_ = Prince3.PrinceSystem.curUser.gameResult[_loc7_].length;
                  _loc5_ = 0;
                  while(_loc5_ < _loc11_)
                  {
                     _loc3_ = Prince3.PrinceSystem.curUser.gameResult[_loc7_][_loc5_];
                     _loc3_[0] = int(_loc3_[0]);
                     _loc3_[1] = Prince3.Utils.str2Date(_loc3_[1]);
                     _loc3_[2] = int(_loc3_[2]);
                     _loc3_[3] = Prince3.Utils.str2Date(_loc3_[3]);
                     _loc3_[4] = int(_loc3_[4]);
                     _loc3_[5] = Prince3.Utils.str2Date(_loc3_[5]);
                     _loc5_ = _loc5_ + 1;
                  }
                  _loc7_ = _loc7_ + 1;
               }
               Prince3.PrinceSystem.curUser.gameCards = Prince3.Utils.str2nArray(val.gameCards,",");
               _loc9_ = 0;
               while(_loc9_ < Prince3.PrinceSystem.curUser.gameCards.length)
               {
                  Prince3.PrinceSystem.curUser.gameCards[_loc9_] = int(Prince3.PrinceSystem.curUser.gameCards[_loc9_]);
                  _loc9_ = _loc9_ + 1;
               }
               Prince3.PrinceSystem.curUser.cardSequence = Prince3.Utils.str2nArray(val.cardSequence,",");
               _loc9_ = 0;
               while(_loc9_ < Prince3.PrinceSystem.curUser.cardSequence.length)
               {
                  Prince3.PrinceSystem.curUser.cardSequence[_loc9_] = int(Prince3.PrinceSystem.curUser.cardSequence[_loc9_]);
                  _loc9_ = _loc9_ + 1;
               }
               _loc12_ = ["LOW","MEDIUM","HIGH"];
               _root._quality = _loc12_[Prince3.PrinceSystem.curUser.screen_quality];
               _loc12_ = [0,33,66,100];
               Prince3.SoundSystem.maxVal = _loc12_[Prince3.PrinceSystem.curUser.sound_level];
               Prince3.PrinceSystem.loadMap();
            }
         }
      }
      else
      {
         flash.external.ExternalInterface.call("alert","Unknow error.");
         Prince3.PrinceSystem.reset();
      }
   }
   static function save()
   {
      var _loc2_;
      var _loc3_;
      var _loc4_;
      if(Prince3.PrinceSystem.online)
      {
         Stage.displayState = Prince3.PrinceSystem.curUser.fullscreen != 1 ? "normal" : "fullScreen";
         trace("save online");
         _loc2_ = new Array();
         for(var _loc7_ in Prince3.PrinceSystem.updateList)
         {
            if(_loc7_ == "gameScore")
            {
               _loc2_.push({type:"setScore",data:[Prince3.PrinceSystem.updateList[_loc7_].gameId,Prince3.PrinceSystem.updateList[_loc7_].gameLv,Prince3.PrinceSystem.updateList[_loc7_].data[0],Prince3.Utils.date2Str(Prince3.PrinceSystem.updateList[_loc7_].data[1]),Prince3.PrinceSystem.updateList[_loc7_].data[2],Prince3.Utils.date2Str(Prince3.PrinceSystem.updateList[_loc7_].data[3]),Prince3.PrinceSystem.updateList[_loc7_].data[4],Prince3.Utils.date2Str(Prince3.PrinceSystem.updateList[_loc7_].data[5])]});
            }
            else if(_loc7_ == "gems" || _loc7_ == "items" || _loc7_ == "cards" || _loc7_ == "cardSequence" || _loc7_ == "gameCards")
            {
               _loc2_.push({type:_loc7_,data:Prince3.Utils.nArray2Str(Prince3.PrinceSystem.curUser[_loc7_],",")});
               if(_loc7_ == "gems")
               {
                  _loc2_.push({type:"tGem",data:Prince3.PrinceSystem.totalGems()});
               }
               else if(_loc7_ == "items")
               {
                  _loc2_.push({type:"tItem",data:Prince3.PrinceSystem.totalWeapon()});
               }
               else if(_loc7_ == "cards")
               {
                  _loc2_.push({type:"tCard",data:Prince3.PrinceSystem.totalCards()});
               }
               else if(_loc7_ == "cardSequence")
               {
                  _loc2_.push({type:"cardSequence",data:Prince3.PrinceSystem.totalWeapon()});
               }
               else if(_loc7_ == "gameCards")
               {
                  _loc2_.push({type:"gameCards",data:Prince3.PrinceSystem.totalWeapon()});
               }
            }
            else
            {
               _loc2_.push({type:_loc7_,data:Prince3.PrinceSystem.curUser[_loc7_]});
            }
         }
         Prince3.PrinceSystem.updateList = new Object();
         Prince3.PrinceSystem.serviceRequest(_loc2_);
      }
      else
      {
         trace("save offline");
         if(Prince3.PrinceSystem.curUser)
         {
            trace("save user change");
            _loc3_ = 0;
            while(_loc3_ < Prince3.PrinceSystem.users.length)
            {
               _loc4_ = Prince3.PrinceSystem.users[_loc3_].split("\n");
               if(_loc4_[1] == Prince3.PrinceSystem.curUser.userName)
               {
                  Prince3.PrinceSystem.users[_loc3_] = Prince3.PrinceSystem.createUserText(Prince3.PrinceSystem.curUser.userName,Prince3.PrinceSystem.curUser.sex,Prince3.PrinceSystem.curUser.schoolName,Prince3.PrinceSystem.curUser.schoolType,Prince3.PrinceSystem.curUser.classLv,Prince3.PrinceSystem.curUser.className,Prince3.PrinceSystem.curUser.score,Prince3.PrinceSystem.curUser.gems,Prince3.PrinceSystem.curUser.gameCards,Prince3.PrinceSystem.curUser.cards,Prince3.PrinceSystem.curUser.items,Prince3.PrinceSystem.curUser.process,Prince3.PrinceSystem.curUser.cardSequence,Prince3.PrinceSystem.curUser.gameResult,Prince3.PrinceSystem.curUser.screen_quality,Prince3.PrinceSystem.curUser.fullscreen,Prince3.PrinceSystem.curUser.sound_level,Prince3.PrinceSystem.curUser.language);
                  break;
               }
               _loc3_ = _loc3_ + 1;
            }
         }
         if(!_root.mc_trial._visible)
         {
            _root.applicationSaveRecord(Prince3.PrinceSystem.users);
         }
      }
   }
   static function getUserNameList()
   {
      Prince3.PrinceSystem.online = false;
      Prince3.PrinceSystem.users = _root.applicationReadRecord();
      if(!Prince3.PrinceSystem.users)
      {
         Prince3.PrinceSystem.users = new Array(6);
      }
      var _loc4_ = new Array(Prince3.PrinceSystem.users.length);
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < Prince3.PrinceSystem.users.length)
      {
         _loc3_ = Prince3.PrinceSystem.users[_loc2_].split("\n");
         _loc4_[_loc2_] = _loc3_[1];
         _loc2_ = _loc2_ + 1;
      }
      trace(_loc4_);
      return _loc4_;
   }
   static function null2str(input)
   {
      return !input ? "" : String(input);
   }
   static function createUserText(userName, sex, schoolName, schoolType, classLv, className, score, gems, gameCards, cards, items, process, cardSequence, gameResult, screen_quality, fullscreen, sound_level, language)
   {
      var _loc6_ = "V1.0\n" + userName + "\n";
      _loc6_ += userName + "\n";
      _loc6_ += "\n";
      _loc6_ += sex + "\n";
      _loc6_ += schoolName + "\n";
      _loc6_ += schoolType + "\n";
      _loc6_ += classLv + "\n";
      _loc6_ += className + "\n";
      _loc6_ += score + "\n";
      _loc6_ += Prince3.Utils.nArray2Str(gems,",") + "\n";
      var _loc5_ = "";
      var _loc3_ = 0;
      var _loc4_;
      var _loc2_;
      var _loc1_;
      while(_loc3_ < gameResult.length)
      {
         if(_loc3_)
         {
            _loc5_ += ",";
         }
         _loc4_ = gameResult[_loc3_];
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            if(_loc2_)
            {
               _loc5_ += ";";
            }
            _loc1_ = _loc4_[_loc2_];
            _loc5_ += Prince3.PrinceSystem.null2str(_loc1_[0]) + "#" + Prince3.Utils.date2Str(_loc1_[1]) + "#" + Prince3.PrinceSystem.null2str(_loc1_[2]) + "#" + Prince3.Utils.date2Str(_loc1_[3]) + "#" + Prince3.PrinceSystem.null2str(_loc1_[4]) + "#" + Prince3.Utils.date2Str(_loc1_[5]);
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      _loc6_ += _loc5_ + "\n";
      _loc6_ += Prince3.Utils.nArray2Str(gameCards,",") + "\n";
      _loc6_ += Prince3.Utils.nArray2Str(cards,",") + "\n";
      _loc6_ += Prince3.Utils.nArray2Str(items,",") + "\n";
      _loc6_ += Prince3.Utils.nArray2Str(process,",") + "\n";
      _loc6_ += Prince3.Utils.nArray2Str(cardSequence,",") + "\n";
      _loc6_ += screen_quality + "\n";
      _loc6_ += fullscreen + "\n";
      _loc6_ += sound_level + "\n";
      _loc6_ += language + "\n";
      return _loc6_;
   }
   static function addUser(userID, userName, sex, schoolName, schoolType, classLv, className)
   {
      trace("add user");
      var _loc2_ = 0;
      var _loc3_;
      while(_loc2_ < Prince3.PrinceSystem.users.length)
      {
         if(Prince3.PrinceSystem.users[_loc2_])
         {
            _loc3_ = Prince3.PrinceSystem.users[_loc2_].split("\n");
            if(_loc3_[0] == userName)
            {
               return false;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc4_ = new Array(Prince3.PrinceSystem.miniGameSetting.length);
      var _loc1_ = 0;
      while(_loc1_ < Prince3.PrinceSystem.miniGameSetting.length)
      {
         _loc4_[_loc1_] = Prince3.Utils.nArray(Prince3.PrinceSystem.miniGameSetting[_loc1_].length,6);
         _loc1_ = _loc1_ + 1;
      }
      Prince3.PrinceSystem.users[userID] = Prince3.PrinceSystem.createUserText(userName,sex,schoolName,schoolType,classLv,className,0,[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0],[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],_loc4_,2,0,3,0);
      Prince3.PrinceSystem.save();
      return true;
   }
   static function updateUserInfo(userID, userName, classLv)
   {
      var _loc1_ = Prince3.PrinceSystem.getUser(userID);
      if(_loc1_)
      {
         Prince3.PrinceSystem.users[userID] = Prince3.PrinceSystem.createUserText(userName,_loc1_.sex,_loc1_.schoolName,_loc1_.schoolType,classLv,_loc1_.className,_loc1_.score,_loc1_.gems,_loc1_.gameCards,_loc1_.cards,_loc1_.items,_loc1_.process,_loc1_.cardSequence,_loc1_.gameResult,_loc1_.screen_quality,_loc1_.fullscreen,_loc1_.sound_level,_loc1_.language);
         Prince3.PrinceSystem.save();
         return true;
      }
      return false;
   }
   static function delUser(userID)
   {
      if(Prince3.PrinceSystem.users[userID])
      {
         Prince3.PrinceSystem.users[userID] = null;
         Prince3.PrinceSystem.save();
         return true;
      }
      return false;
   }
   static function getUser(userID)
   {
      var _loc7_;
      var _loc2_;
      var _loc5_;
      var _loc4_;
      var _loc6_;
      var _loc3_;
      var _loc1_;
      if(Prince3.PrinceSystem.users[userID])
      {
         _loc7_ = Prince3.PrinceSystem.users[userID].split("\n");
         _loc2_ = new Prince3.User();
         _loc2_.userName = _loc7_[1];
         _loc2_.loginName = _loc7_[2];
         _loc2_.password = _loc7_[3];
         _loc2_.sex = int(_loc7_[4]);
         _loc2_.schoolName = _loc7_[5];
         _loc2_.schoolType = int(_loc7_[6]);
         _loc2_.classLv = int(_loc7_[7]);
         _loc2_.className = _loc7_[8];
         _loc2_.score = int(_loc7_[9]);
         _loc2_.gems = Prince3.Utils.str2nArray(_loc7_[10],",");
         _loc5_ = 0;
         while(_loc5_ < _loc2_.gems.length)
         {
            _loc2_.gems[_loc5_] = int(_loc2_.gems[_loc5_]);
            _loc5_ = _loc5_ + 1;
         }
         _loc2_.gameResult = Prince3.Utils.str2nArray(_loc7_[11],",",";","#");
         _loc4_ = 0;
         while(_loc4_ < _loc2_.gameResult.length)
         {
            _loc6_ = _loc2_.gameResult[_loc4_].length;
            _loc3_ = 0;
            while(_loc3_ < _loc6_)
            {
               _loc1_ = _loc2_.gameResult[_loc4_][_loc3_];
               _loc1_[0] = int(_loc1_[0]);
               _loc1_[1] = Prince3.Utils.str2Date(_loc1_[1]);
               _loc1_[2] = int(_loc1_[2]);
               _loc1_[3] = Prince3.Utils.str2Date(_loc1_[3]);
               _loc1_[4] = int(_loc1_[4]);
               _loc1_[5] = Prince3.Utils.str2Date(_loc1_[5]);
               _loc3_ = _loc3_ + 1;
            }
            _loc4_ = _loc4_ + 1;
         }
         _loc2_.gameCards = Prince3.Utils.str2nArray(_loc7_[12],",");
         _loc5_ = 0;
         while(_loc5_ < _loc2_.gameCards.length)
         {
            _loc2_.gameCards[_loc5_] = int(_loc2_.gameCards[_loc5_]);
            _loc5_ = _loc5_ + 1;
         }
         _loc2_.cards = Prince3.Utils.str2nArray(_loc7_[13],",");
         _loc5_ = 0;
         while(_loc5_ < _loc2_.cards.length)
         {
            _loc2_.cards[_loc5_] = int(_loc2_.cards[_loc5_]);
            _loc5_ = _loc5_ + 1;
         }
         _loc2_.items = Prince3.Utils.str2nArray(_loc7_[14],",");
         _loc5_ = 0;
         while(_loc5_ < _loc2_.items.length)
         {
            _loc2_.items[_loc5_] = int(_loc2_.items[_loc5_]);
            _loc5_ = _loc5_ + 1;
         }
         _loc2_.process = Prince3.Utils.str2nArray(_loc7_[15],",");
         _loc5_ = 0;
         while(_loc5_ < _loc2_.process.length)
         {
            _loc2_.process[_loc5_] = int(_loc2_.process[_loc5_]);
            _loc5_ = _loc5_ + 1;
         }
         _loc2_.cardSequence = Prince3.Utils.str2nArray(_loc7_[16],",");
         _loc5_ = 0;
         while(_loc5_ < _loc2_.cardSequence.length)
         {
            _loc2_.cardSequence[_loc5_] = int(_loc2_.cardSequence[_loc5_]);
            _loc5_ = _loc5_ + 1;
         }
         _loc2_.screen_quality = int(_loc7_[17]);
         _loc2_.fullscreen = int(_loc7_[18]);
         _loc2_.sound_level = int(_loc7_[19]);
         _loc2_.language = int(_loc7_[20]);
         return _loc2_;
      }
      return null;
   }
   static function settingChange(name, value)
   {
      if(Prince3.PrinceSystem.curUser)
      {
         Prince3.PrinceSystem.curUser[name] = value;
         Prince3.PrinceSystem.updateList[name] = true;
      }
   }
   static function gemChange(gemId, num)
   {
      if(Prince3.PrinceSystem.curUser)
      {
         Prince3.PrinceSystem.curUser.gems[gemId] += num;
         Prince3.PrinceSystem.updateList.gems = true;
      }
   }
   static function itemChange(itemId, num)
   {
      if(Prince3.PrinceSystem.curUser)
      {
         Prince3.PrinceSystem.curUser.items[itemId] += num;
         Prince3.PrinceSystem.updateList.items = true;
      }
   }
   static function setCard(cardId)
   {
      if(Prince3.PrinceSystem.curUser)
      {
         Prince3.PrinceSystem.curUser.cards[int(cardId / 7)] |= 1 << cardId % 7;
         Prince3.PrinceSystem.updateList.cards = true;
      }
   }
   static function gameCardChange(cardId, num)
   {
      if(Prince3.PrinceSystem.curUser)
      {
         Prince3.PrinceSystem.curUser.gameCards[cardId] += num;
         Prince3.PrinceSystem.updateList.gameCards = true;
      }
   }
   static function cardSequenceChange(seqId, cardId)
   {
      if(Prince3.PrinceSystem.curUser)
      {
         Prince3.PrinceSystem.curUser.cardSequence[seqId] = cardId;
         Prince3.PrinceSystem.updateList.cardSequence = true;
      }
   }
   static function scoreChange(num)
   {
      if(Prince3.PrinceSystem.curUser)
      {
         Prince3.PrinceSystem.curUser.score += num;
         Prince3.PrinceSystem.updateList.score = true;
      }
   }
   static function killBoss()
   {
      if(Prince3.PrinceSystem.curUser)
      {
         if(Prince3.PrinceSystem.curUser.process[0] < 3)
         {
            Prince3.PrinceSystem.curUser.process[0]++;
         }
         Prince3.PrinceSystem.updateList.process = true;
      }
   }
   static function saveGameScore(gameId, gameLv, gameScore)
   {
      var _loc1_;
      if(Prince3.PrinceSystem.curUser)
      {
         _loc1_ = Prince3.PrinceSystem.curUser.gameResult[gameId][gameLv - 1];
         if(_loc1_[1])
         {
            if(gameScore > _loc1_[2])
            {
               _loc1_[2] = gameScore;
               _loc1_[3] = new Date();
            }
         }
         else
         {
            _loc1_[0] = gameScore;
            _loc1_[1] = new Date();
            _loc1_[2] = gameScore;
            _loc1_[3] = new Date();
         }
         _loc1_[4] = gameScore;
         _loc1_[5] = new Date();
         Prince3.PrinceSystem.updateList.gameScore = {gameId:gameId,gameLv:gameLv,data:_loc1_};
      }
   }
   static function totalGems(user)
   {
      var _loc3_ = 0;
      var _loc1_ = 0;
      while(_loc1_ < user.gems.length)
      {
         _loc3_ += user.gems[_loc1_];
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   static function totalWeapon(user)
   {
      var _loc3_ = 0;
      var _loc1_ = 0;
      while(_loc1_ < user.gameCards.length)
      {
         _loc3_ += user.gameCards[_loc1_];
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = 0;
      while(_loc1_ < user.cardSequence.length)
      {
         if(int(user.cardSequence[_loc1_]))
         {
            _loc3_ = _loc3_ + 1;
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   static function totalCards(user)
   {
      var _loc4_ = 0;
      var _loc2_ = 0;
      var _loc1_;
      while(_loc2_ < user.cards.length)
      {
         _loc1_ = 1;
         while(_loc1_ < 128)
         {
            if(user.cards[_loc2_] & _loc1_)
            {
               _loc4_ = _loc4_ + 1;
            }
            _loc1_ <<= 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   static function totalCards1(user)
   {
      var _loc3_ = 0;
      var _loc5_ = int(user.cards.length / 2);
      var _loc2_ = 0;
      var _loc1_;
      while(_loc2_ < _loc5_)
      {
         _loc1_ = 1;
         while(_loc1_ < 128)
         {
            if(user.cards[_loc2_] & _loc1_)
            {
               _loc3_ = _loc3_ + 1;
            }
            _loc1_ <<= 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   static function totalCards2(user)
   {
      var _loc4_ = 0;
      var _loc5_ = int(user.cards.length / 2);
      var _loc2_ = _loc5_;
      var _loc1_;
      while(_loc2_ < user.cards.length)
      {
         _loc1_ = 1;
         while(_loc1_ < 128)
         {
            if(user.cards[_loc2_] & _loc1_)
            {
               _loc4_ = _loc4_ + 1;
            }
            _loc1_ <<= 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   static function finishPercent()
   {
      if(Prince3.PrinceSystem.curUser)
      {
         return Prince3.PrinceSystem.finishPercentOfResult(Prince3.PrinceSystem.curUser.gameResult);
      }
      return null;
   }
   static function finishPercentOfResult(r)
   {
      var _loc4_ = 0;
      var _loc6_ = 0;
      var _loc3_ = 0;
      var _loc2_;
      var _loc1_;
      while(_loc3_ < r.length)
      {
         _loc2_ = r[_loc3_];
         _loc6_ += _loc2_.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            if(_loc2_[_loc1_][1] != null)
            {
               if(_loc2_[_loc1_][0] >= Prince3.PrinceSystem.miniGameSetting[_loc3_][_loc1_].maxscore)
               {
                  _loc4_ = _loc4_ + 1;
               }
            }
            _loc1_ = _loc1_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc4_ * 100 / _loc6_;
   }
   static function getRank()
   {
      var _loc3_;
      var _loc2_;
      var _loc1_;
      var _loc6_;
      var _loc5_;
      var _loc4_;
      if(Prince3.PrinceSystem.online)
      {
         Prince3.PrinceSystem.application.content.mcPop.myRank.updateTopRankView(new Array(),new Array(),new Array());
         Prince3.PrinceSystem.application.content.mcPop.myRank.updateRankView(0);
         Prince3.PrinceSystem.serviceRequest([{type:"getRank"}]);
      }
      else
      {
         _loc3_ = new Array();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = Prince3.PrinceSystem.getUser(_loc2_);
            if(_loc1_)
            {
               _loc1_.t_star = Prince3.PrinceSystem.totalGems(_loc1_);
               _loc1_.t_card = Prince3.PrinceSystem.totalCards(_loc1_);
               _loc1_.t_card1 = Prince3.PrinceSystem.totalCards1(_loc1_);
               _loc1_.t_card2 = Prince3.PrinceSystem.totalCards2(_loc1_);
               _loc1_.t_weapon = Prince3.PrinceSystem.totalWeapon(_loc1_);
               _loc1_.t_item = _loc1_.t_card + _loc1_.t_weapon;
               _loc1_.sex = 0;
               _loc3_.push(_loc1_);
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc6_ = _loc3_.concat();
         _loc6_.sort(Prince3.PrinceSystem.orderScore);
         _loc5_ = _loc3_.concat();
         _loc5_.sort(Prince3.PrinceSystem.orderStar);
         _loc4_ = _loc3_.concat();
         _loc4_.sort(Prince3.PrinceSystem.orderItem);
         Prince3.PrinceSystem.application.content.mcPop.myRank.updateTopRankView(_loc6_,_loc5_,_loc4_);
         Prince3.PrinceSystem.application.content.mcPop.myRank.updateRankView(0);
      }
   }
   static function orderScore(a, b)
   {
      return a.score < b.score ? 1 : -1;
   }
   static function orderStar(a, b)
   {
      return a.t_star < b.t_star ? 1 : -1;
   }
   static function orderItem(a, b)
   {
      return a.t_item < b.t_item ? 1 : -1;
   }
   static function reset()
   {
      Prince3.PrinceSystem.mapRecord = null;
      Prince3.PrinceSystem.curUser = null;
      Prince3.PrinceSystem.kctrl = null;
      Prince3.PrinceSystem.pause = false;
      Prince3.PrinceSystem.application.mcHint.gotoAndStop(1);
      Prince3.PrinceSystem.application.mcHeader.hideHeader();
      Prince3.PrinceSystem.application.gamebar.unloadMovie();
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
      Prince3.PrinceSystem.loadLogin();
   }
   static function showHint(pmHint)
   {
      Prince3.PrinceSystem.application.mcHint.gotoAndStop(!pmHint ? 1 : pmHint);
   }
   static function loadReg()
   {
      Prince3.PrinceSystem.cardInfo = Prince3.Setting.cardInfo;
      Prince3.PrinceSystem.cardSetting = Prince3.Setting.cardSetting;
      Prince3.PrinceSystem.miniGameSetting = Prince3.Setting.miniGameSetting;
      Prince3.PrinceSystem.status = "reg";
      Prince3.PrinceSystem.application.loading.preload([{url:"reg.swf",target:Prince3.PrinceSystem.application.content}],Prince3.PrinceSystem.onloadRegComplete);
   }
   static function onloadRegComplete()
   {
      Prince3.PrinceSystem.application.checkActivation();
   }
   static function loadOpening()
   {
      Prince3.PrinceSystem.status = "opening";
      Prince3.PrinceSystem.application.loading.preload([{url:"opening.swf",target:Prince3.PrinceSystem.application.content}],null);
   }
   static function loadLogin()
   {
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.application.content.unloadMovie();
      Prince3.PrinceSystem.status = "login";
      if(Prince3.PrinceSystem.curBGM)
      {
         Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,24);
      }
      Prince3.SoundSystem.preLoadComplete = Prince3.PrinceSystem.onloadLoginSound;
      Prince3.SoundSystem.preloadByArray(["bgm/bgm-2","sfx/ding","sfx/right","sfx/wrong","sfx/score","sfx/drag","sfx/drop","sfx/bob","sfx/sel1","sfx/sel2","sfx/sel3","sfx/sel4","sfx/sel5","sfx/sel6","sfx/sel7","sfx/sel8","sfx/ingame","sfx/inhouse","sfx/reducechance","sfx/timeup","sfx/slide"]);
   }
   static function onloadLoginSound()
   {
      Prince3.SoundSystem.preLoadComplete = null;
      Prince3.PrinceSystem.application.loading.preload([{url:"login.swf",target:Prince3.PrinceSystem.application.content}],Prince3.PrinceSystem.onloadLoginComplete);
   }
   static function onloadLoginComplete()
   {
      Prince3.PrinceSystem.unblurBG();
      Prince3.PrinceSystem.curBGM = "bgm/bgm-2";
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
   }
   static function login(userID)
   {
      trace("login");
      trace(Prince3.PrinceSystem.users[0]);
      Prince3.PrinceSystem.curUser = Prince3.PrinceSystem.getUser(userID);
      var _loc2_ = ["LOW","MEDIUM","HIGH"];
      _root._quality = _loc2_[Prince3.PrinceSystem.curUser.screen_quality];
      _loc2_ = [0,33,66,100];
      Prince3.SoundSystem.maxVal = _loc2_[Prince3.PrinceSystem.curUser.sound_level];
      if(Prince3.PrinceSystem.curUser.fullscreen == 0)
      {
         _root.applicationWindowMode();
      }
      else
      {
         _root.applicationFullScreenMode();
      }
      Prince3.PrinceSystem.loadMap();
   }
   static function webLogin(loginname, password)
   {
      Prince3.PrinceSystem.online = true;
      Prince3.PrinceSystem.serviceRequest([{type:"login",loginname:loginname,password:password}]);
   }
   static function loadMap()
   {
      Mouse.show();
      Prince3.SoundSystem.releaseGameSound();
      Prince3.PrinceSystem.cheatCode = "";
      Prince3.PrinceSystem.backFromGame = Prince3.PrinceSystem.status == "game";
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.application.content.unloadMovie();
      Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,24);
      Prince3.SoundSystem.preLoadComplete = Prince3.PrinceSystem.onloadMapSound;
      Prince3.SoundSystem.preloadByArray(["bgm/villagetheme"]);
      Prince3.PrinceSystem.application.gamebar.unloadMovie();
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
   }
   static function onloadMapSound()
   {
      Prince3.PrinceSystem.application.loading.preload([{url:"village.swf",target:Prince3.PrinceSystem.application.content}],Prince3.PrinceSystem.onloadMapComplete);
   }
   static function onloadMapComplete()
   {
      Prince3.PrinceSystem.unblurBG();
      trace("onloadMapComplete");
      Prince3.PrinceSystem.curBGM = "bgm/villagetheme";
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
      if(Prince3.PrinceSystem.status != "game")
      {
         Prince3.PrinceSystem.application.mcHeader.showHeader();
      }
      Prince3.PrinceSystem.status = "map";
   }
   static function loadCardSequenceMenu()
   {
      Prince3.PrinceSystem.pause = true;
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
      Prince3.PrinceSystem.application.mcHeader.mcScore.gotoAndStop(1);
      Prince3.PrinceSystem.application.mcHeader.mcPaneL.gotoAndStop(1);
      Prince3.PrinceSystem.application.loading.preload([{url:"cardseq.swf",target:Prince3.PrinceSystem.application.gamebar}],null);
   }
   static function loadBuyCard()
   {
      Prince3.PrinceSystem.status = "buy card";
      Prince3.PrinceSystem.pause = true;
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
      Prince3.PrinceSystem.application.mcHeader.mcScore.gotoAndStop(1);
      Prince3.PrinceSystem.application.mcHeader.mcPaneL.gotoAndStop(1);
      Prince3.PrinceSystem.application.mcHeader.prepareGame2();
      Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,24);
      Prince3.SoundSystem.preLoadComplete = Prince3.PrinceSystem.onloadBuyCardSound;
      Prince3.SoundSystem.preloadByArray(["bgm/trader"]);
   }
   static function onloadBuyCardSound()
   {
      Prince3.PrinceSystem.application.loading.preload([{url:"buycard.swf",target:Prince3.PrinceSystem.application.gamebar}],Prince3.PrinceSystem.onloadBuyCardComplete);
   }
   static function onloadBuyCardComplete()
   {
      Prince3.PrinceSystem.curBGM = "bgm/trader";
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
   }
   static function canCloseBuyCard()
   {
      trace(Prince3.PrinceSystem.application.gamebar.buycard.status);
      return Prince3.PrinceSystem.application.gamebar.buycard.status == "run";
   }
   static function closeBuyCard()
   {
      Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,24);
      Prince3.PrinceSystem.curBGM = "bgm/villagetheme";
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
      Prince3.PrinceSystem.status = "map";
      Prince3.PrinceSystem.unblurBG();
      Prince3.PrinceSystem.application.mcHeader.showHeader();
      Prince3.PrinceSystem.application.gamebar.unloadMovie();
   }
   static function loadGameSelectMenu(area)
   {
      Prince3.PrinceSystem.status = "game select menu";
      Prince3.PrinceSystem.gameArea = area;
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
      Prince3.PrinceSystem.application.mcHeader.prepareGame2();
      Prince3.PrinceSystem.application.loading.preload([{url:"showgame.swf",target:Prince3.PrinceSystem.application.gamebar}],Prince3.PrinceSystem.onloadGameSelectMenuComplete);
   }
   static function onloadGameSelectMenuComplete()
   {
      if(Prince3.PrinceSystem.backFromGame && Prince3.PrinceSystem.curBGM != "bgm/villagetheme")
      {
         Prince3.PrinceSystem.curBGM = "bgm/villagetheme";
         Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
      }
      Prince3.PrinceSystem.application.mcHeader.switchGame();
   }
   static function closeGameSelectMenu()
   {
      Prince3.PrinceSystem.status = "map";
      Prince3.PrinceSystem.unblurBG();
      Prince3.PrinceSystem.application.mcHeader.showHeader();
      Prince3.PrinceSystem.application.gamebar.unloadMovie();
   }
   static function loadHome()
   {
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.application.content.unloadMovie();
      Prince3.PrinceSystem.status = "home";
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
      Prince3.PrinceSystem.application.mcHeader.prepareGame2();
      Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,24);
      Prince3.SoundSystem.preLoadComplete = Prince3.PrinceSystem.onloadHomeSound;
      Prince3.SoundSystem.preloadByArray(["bgm/home"]);
   }
   static function onloadHomeSound()
   {
      Prince3.PrinceSystem.application.loading.preload([{url:"home.swf",target:Prince3.PrinceSystem.application.content}],Prince3.PrinceSystem.onloadHomeComplete);
   }
   static function onloadHomeComplete()
   {
      Prince3.PrinceSystem.unblurBG();
      Prince3.PrinceSystem.curBGM = "bgm/home";
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
      Prince3.PrinceSystem.application.mcHeader.switchGame();
   }
   static function loadPreBattle()
   {
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.status = "prebattle";
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
      Prince3.PrinceSystem.application.mcHeader.mcScore.gotoAndStop(1);
      Prince3.PrinceSystem.application.mcHeader.mcPaneL.gotoAndStop(1);
      Prince3.PrinceSystem.application.mcHeader.prepareGame2();
      Prince3.PrinceSystem.application.loading.preload([{url:"warinst.swf",target:Prince3.PrinceSystem.application.gamebar}],Prince3.PrinceSystem.onloadPreBattleComplete);
   }
   static function onloadPreBattleComplete()
   {
      Prince3.PrinceSystem.application.mcHeader.switchGame();
   }
   static function loadBattle()
   {
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.application.gamebar.unloadMovie();
      Prince3.PrinceSystem.application.content.unloadMovie();
      Prince3.PrinceSystem.status = "battle";
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
      Prince3.PrinceSystem.application.mcHeader.mcPaneL.gotoAndStop(1);
      Prince3.PrinceSystem.application.mcHeader.mcScore.gotoAndStop(1);
      Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,24);
      Prince3.SoundSystem.preLoadComplete = Prince3.PrinceSystem.onloadBattleSound;
      Prince3.SoundSystem.preloadByArray([Prince3.PrinceSystem.boss != 2 ? "bgm/battle_miniboss" : "bgm/battle_bigboss","sfx/short_bigboss","sfx/short_miniboss"]);
   }
   static function onloadBattleSound()
   {
      Prince3.PrinceSystem.application.loading.preload([{url:"war.swf",target:Prince3.PrinceSystem.application.content}],Prince3.PrinceSystem.onloadBattleComplete);
   }
   static function onloadBattleComplete()
   {
      Prince3.PrinceSystem.unblurBG();
      Prince3.PrinceSystem.curBGM = Prince3.PrinceSystem.boss != 2 ? "bgm/battle_miniboss" : "bgm/battle_bigboss";
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
   }
   static function loadEnding()
   {
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.status = "ending";
      Prince3.PrinceSystem.application.mcHeader.hideHeader();
      Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,24);
      Prince3.PrinceSystem.application.loading.preload([{url:"ending.swf",target:Prince3.PrinceSystem.application.content}],Prince3.PrinceSystem.onloadEndingComplete);
      Prince3.PrinceSystem.application.loading._visible = false;
   }
   static function onloadEndingComplete()
   {
      Prince3.PrinceSystem.unblurBG();
   }
   static function loadGame(name)
   {
      Prince3.PrinceSystem.status = "game";
      Prince3.PrinceSystem.gameName = name;
      Prince3.PrinceSystem.application.loading._visible = true;
      Prince3.PrinceSystem.application.content.unloadMovie();
      Prince3.PrinceSystem.application.mcFooter.gotoAndStop("none");
      Prince3.PrinceSystem.application.mcHeader.prepareGame2();
      var _loc2_ = ["a1","a2","a3","a4","a5","a6","a7","b1","b2","b3","c1","c2","c3","c4","c5","c6","c7","_m1","_m2","_m3","_e1","_e2","_e3","_e4"];
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         if(Prince3.PrinceSystem.gameName == _loc2_[_loc1_])
         {
            Prince3.PrinceSystem.gameNumber = _loc1_;
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(Prince3.PrinceSystem.gameNumber < 7)
      {
         Prince3.PrinceSystem.gameArea = 0;
      }
      else if(Prince3.PrinceSystem.gameNumber < 10)
      {
         Prince3.PrinceSystem.gameArea = 1;
      }
      else if(Prince3.PrinceSystem.gameNumber < 17)
      {
         Prince3.PrinceSystem.gameArea = 2;
      }
      else if(Prince3.PrinceSystem.gameNumber < 20)
      {
         Prince3.PrinceSystem.gameArea = 3;
      }
      else
      {
         Prince3.PrinceSystem.gameArea = 4;
      }
      Prince3.SoundSystem.fadeOut(Prince3.PrinceSystem.curBGM,24);
      Prince3.SoundSystem.preLoadComplete = Prince3.PrinceSystem.onloadGameSound;
      Prince3.SoundSystem.preloadByArray(["bgm/game" + Prince3.PrinceSystem.gameArea]);
   }
   static function onloadGameSound()
   {
      Prince3.PrinceSystem.application.loading.preload([{url:"gamebar.swf",target:Prince3.PrinceSystem.application.gamebar}],Prince3.PrinceSystem.onloadGameBarComplete);
   }
   static function onloadGameBarComplete()
   {
      Prince3.PrinceSystem.application.loading.preload([{url:"game" + Prince3.PrinceSystem.gameName + ".swf",target:Prince3.PrinceSystem.application.content}],Prince3.PrinceSystem.onloadGameComplete);
   }
   static function onloadGameComplete()
   {
      Prince3.PrinceSystem.blurBG();
      Prince3.PrinceSystem.curBGM = "bgm/game" + Prince3.PrinceSystem.gameArea;
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
      Prince3.PrinceSystem.application.mcHeader.switchGame();
   }
   static function showSelectLevel()
   {
      trace("showlv :" + Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber].length);
      Prince3.PrinceSystem.gamebar.showLevel(Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber].length);
      Prince3.PrinceSystem.game.gotoAndStop("select level");
   }
   static function gameInit(level)
   {
      Prince3.PrinceSystem.curMiniGameSetting = Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber][level - 1];
      Prince3.PrinceSystem.gameLevel = level;
      Prince3.PrinceSystem.application.mcHeader.switchInGame();
      Prince3.PrinceSystem.application.mcFooter.showFooter();
      Prince3.PrinceSystem.application.mcFooter.setFooterType(Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber][level - 1]);
      Prince3.PrinceSystem.game.gameInit();
   }
   static function showPreload()
   {
      Prince3.PrinceSystem.gamebar.showPreload();
   }
   static function miniGamePreload()
   {
      Prince3.PrinceSystem.game.preload();
   }
   static function showReady()
   {
      Prince3.PrinceSystem.unblurBG();
      Prince3.PrinceSystem.gamebar.showReady();
      Prince3.PrinceSystem.game.gotoAndStop("ready");
      Prince3.SoundSystem.fadeInOut(Prince3.PrinceSystem.curBGM,24,Prince3.SoundSystem.maxVal * 0.7);
   }
   static function replay()
   {
      Prince3.PrinceSystem.curMiniGameSetting = Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber][Prince3.PrinceSystem.gameLevel - 1];
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
      Prince3.SoundSystem.fadeInOut(Prince3.PrinceSystem.curBGM,24,Prince3.SoundSystem.maxVal * 0.7);
      Prince3.PrinceSystem.application.mcHeader.switchInGame();
      Prince3.PrinceSystem.gamebar.replay();
      Prince3.PrinceSystem.application.mcFooter.resetFooterType(Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber][Prince3.PrinceSystem.gameLevel - 1]);
   }
   static function backToSelectLevel()
   {
      Prince3.PrinceSystem.gamebar.showLevel(Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber].length);
      Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.gotoAndPlay("toGame");
      Prince3.PrinceSystem.application.mcFooter.play();
      Prince3.PrinceSystem.game.gotoAndStop("select level");
      Prince3.SoundSystem.fadeIn(Prince3.PrinceSystem.curBGM,24);
   }
   static function exitGameToSelectLevel()
   {
      Prince3.PrinceSystem.gamebar.showLevel(Prince3.PrinceSystem.miniGameSetting[Prince3.PrinceSystem.gameNumber].length);
      Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.gotoAndPlay("toGame");
      Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.btnLeaveGame.gotoAndPlay("enter");
      Prince3.PrinceSystem.application.mcFooter.play();
      Prince3.PrinceSystem.game.gotoAndStop("select level");
      delete Prince3.PrinceSystem.game.onEnterFrame;
      Prince3.PrinceSystem.application.mcFooter.startTimer = false;
      Prince3.SoundSystem.stopVO();
   }
   static function playGame()
   {
      Prince3.PrinceSystem.gamebar.gotoAndStop("none");
      Prince3.PrinceSystem.game.playGame();
   }
   static function showGameResult()
   {
      Prince3.PrinceSystem.blurBG();
      if(Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.btnGetResult && Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.btnGetResult.onRollOut)
      {
         Prince3.PrinceSystem.application.mcHeader.mcPaneMenu.gotoAndPlay("ingame");
      }
      Prince3.PrinceSystem.gamebar.showGameRelsult(Prince3.PrinceSystem.application.mcFooter.score,Prince3.PrinceSystem.application.mcFooter.score >= Prince3.PrinceSystem.application.mcFooter.maxscore);
   }
   static function gameAddScore()
   {
      if(arguments.length)
      {
         Prince3.PrinceSystem.application.mcFooter.addScore(arguments[0]);
      }
      else
      {
         Prince3.PrinceSystem.application.mcFooter.addScore();
      }
   }
   static function reduceChance()
   {
      Prince3.PrinceSystem.application.mcFooter.reduceChance();
   }
   static function chanceReset()
   {
      Prince3.PrinceSystem.application.mcFooter.chanceReset();
   }
   static function timerStart()
   {
      Prince3.PrinceSystem.application.mcFooter.timerStart();
   }
   static function timerStop()
   {
      Prince3.PrinceSystem.application.mcFooter.timerStop();
   }
   static function timerReset()
   {
      Prince3.PrinceSystem.application.mcFooter.timerReset();
   }
   static function changePrinceStatus(newStatus)
   {
      Prince3.PrinceSystem.application.mcFooter.changeStatus(newStatus);
   }
   static function blurBG()
   {
      Prince3.PrinceSystem.pause = true;
      Prince3.PrinceSystem.application.bmp.draw(Prince3.PrinceSystem.application.content);
      Prince3.PrinceSystem.application.content._visible = false;
      Prince3.PrinceSystem.application.mc_blur._visible = true;
   }
   static function unblurBG()
   {
      Prince3.PrinceSystem.pause = false;
      Prince3.PrinceSystem.application.content._visible = true;
      Prince3.PrinceSystem.application.mc_blur._visible = false;
   }
}
