class LoginUI extends MovieClip
{
   var btn_buy;
   var btn_del;
   var btn_edit;
   var btn_login;
   var btn_start;
   var btn_trial;
   var id;
   var mc_news;
   var mc_popup;
   var mc_sel;
   var mc_update;
   var sel;
   function LoginUI()
   {
      super();
      trace("LoginUI");
      this.sel = null;
   }
   function checkVersionResponse(ver)
   {
      trace("checkVersionResponse");
      ver = ver.split(",");
      this.mc_update.loadMovie(ver[1]);
      this.mc_news.loadMovie(ver[2]);
   }
   function onLoad()
   {
      if(_root.mc_trial._visible)
      {
         this.gotoAndStop("trial");
         this.btn_trial.onPress = function()
         {
            this.gotoAndStop(3);
         };
         this.btn_trial.onRelease = function()
         {
            Prince3.SoundSystem.playSound("sfx/ding");
            Prince3.PrinceSystem.login(0);
         };
         this.btn_trial.onRollOver = function()
         {
            this.gotoAndStop(2);
            this._parent.mc_hint_trial.gotoAndPlay(2);
         };
         this.btn_trial.onRollOut = this.btn_trial.onReleaseOutside = function()
         {
            this.gotoAndStop(1);
            this._parent.mc_hint_trial.gotoAndStop(1);
         };
         this.btn_buy.onPress = function()
         {
            this.gotoAndStop(3);
         };
         this.btn_buy.onRelease = function()
         {
            this.getURL("http://www.little-prince.com.hk/littleprince/order.htm");
         };
         this.btn_buy.onRollOver = function()
         {
            this.gotoAndStop(2);
            this._parent.mc_hint_buy.gotoAndPlay(2);
         };
         this.btn_buy.onRollOut = this.btn_buy.onReleaseOutside = function()
         {
            this.gotoAndStop(1);
            this._parent.mc_hint_buy.gotoAndStop(1);
         };
      }
      else
      {
         this.gotoAndStop("start");
         this.btn_start.onRelease = function()
         {
            Prince3.SoundSystem.playSound("sfx/ding");
            this._parent.loginPageInit();
         };
      }
      Prince3.PrinceSystem.serviceRequest([{type:"checkVersion",version:this._parent.verNumber}]);
   }
   function btnOnRollOut()
   {
      this.gotoAndStop("normal");
   }
   function btnOnRollOver()
   {
      this.gotoAndStop("over");
   }
   function btnOnPress()
   {
      this.gotoAndStop("down");
   }
   function loginPageInit()
   {
      this.gotoAndStop("login");
      var _loc7_ = Prince3.PrinceSystem.getUserNameList();
      var _loc4_ = 0;
      var _loc2_;
      var _loc5_;
      var _loc3_;
      var _loc6_;
      while(_loc4_ < _loc7_.length)
      {
         _loc2_ = this["mc_slot" + _loc4_];
         _loc2_.gotoAndStop(3);
         _loc2_.id = _loc4_;
         _loc2_.enabled = true;
         _loc2_.onRelease = function()
         {
            Prince3.PrinceSystem.actionCapture(this,"onRelease");
            this._parent.selAccount(this.id);
         };
         _loc2_.onRollOver = function()
         {
            if(!this.mc_sel._visible)
            {
               this.mc_sel._visible = true;
               this.mc_sel.gotoAndStop(1);
            }
         };
         _loc2_.onRollOut = function()
         {
            if(this.mc_sel._visible && this.mc_sel._currentframe == 1)
            {
               this.mc_sel._visible = false;
               this.mc_sel.gotoAndStop(1);
            }
         };
         if(_loc7_[_loc4_])
         {
            _loc2_.gotoAndStop(3);
            _loc2_.txt.text = _loc7_[_loc4_];
            _loc5_ = Prince3.PrinceSystem.getUser(_loc4_);
            _loc2_.score = _loc5_.score;
            _loc2_.classlevel = _loc5_.classLv;
            _loc3_ = 0;
            while(_loc3_ < 8)
            {
               _loc2_["gem" + _loc3_] = Prince3.Utils.num2Str(Prince3.Utils.numLimit(_loc5_.gems[_loc3_],0,999),10,0);
               _loc3_ = _loc3_ + 1;
            }
            _loc6_ = Prince3.PrinceSystem.finishPercentOfResult(_loc5_.gameResult);
            trace(_loc6_ + "%");
            _loc2_.percent.star.setMask(_loc2_.percent.dmask);
            _loc2_.percent.dmask._y = 52 - 32 * _loc6_ / 100;
            _loc2_.percent.bg._y = _loc2_.percent.dmask._y;
         }
         else
         {
            _loc2_.gotoAndStop(1);
         }
         if(this.sel == _loc4_)
         {
            this.selAccount(this.sel);
         }
         else
         {
            _loc2_.mc_sel._visible = false;
            _loc2_.mc_sel.gotoAndStop(1);
         }
         _loc4_ = _loc4_ + 1;
      }
      this.btn_del.onRollOut = this.btn_del.onReleaseOutside = this.btnOnRollOut;
      this.btn_del.onRollOver = this.btnOnRollOver;
      this.btn_del.onPress = this.btnOnPress;
      this.btn_del.enabled = true;
      this.btn_del.onRelease = function()
      {
         this._parent.delAccount();
      };
      this.btn_edit.onRollOut = this.btn_edit.onReleaseOutside = this.btnOnRollOut;
      this.btn_edit.onRollOver = this.btnOnRollOver;
      this.btn_edit.onPress = this.btnOnPress;
      this.btn_edit.enabled = true;
      this.btn_edit.onRelease = function()
      {
         this._parent.editAccount();
      };
      this.btn_login.onRollOut = this.btn_login.onReleaseOutside = this.btnOnRollOut;
      this.btn_login.onRollOver = this.btnOnRollOver;
      this.btn_login.onPress = this.btnOnPress;
      this.btn_login.enabled = true;
      this.btn_login.onRelease = function()
      {
         if(this._parent.sel != null && this._parent["mc_slot" + this._parent.sel]._currentframe == 3)
         {
            Prince3.PrinceSystem.login(this._parent.sel);
         }
      };
      if(this.sel != null && this["mc_slot" + this.sel]._currentframe == 3)
      {
         this.btn_del._visible = true;
         this.btn_edit._visible = true;
         this.btn_login._visible = true;
      }
      else
      {
         this.btn_del._visible = false;
         this.btn_edit._visible = false;
         this.btn_login._visible = false;
      }
   }
   function delAccount()
   {
      if(this.sel != null)
      {
         this.mc_popup.play();
      }
   }
   function editAccount()
   {
      var _loc8_;
      var _loc6_;
      var _loc9_;
      var _loc5_;
      var _loc4_;
      var _loc7_;
      if(this.sel != null)
      {
         _loc8_ = Prince3.PrinceSystem.getUser(this.sel);
         _loc6_ = this["mc_slot" + this.sel];
         _loc6_.gotoAndStop(4);
         _loc6_.txt.text = _loc8_.userName;
         _loc9_ = Prince3.PrinceSystem.finishPercentOfResult(_loc8_.gameResult);
         _loc6_.percent.star.setMask(_loc6_.percent.dmask);
         _loc6_.percent.dmask._y = 52 - 32 * _loc9_ / 100;
         _loc6_.percent.bg._y = _loc6_.percent.dmask._y;
         _loc5_ = 1;
         while(_loc5_ <= 6)
         {
            _loc4_ = _loc6_["mc_lv" + _loc5_];
            _loc4_.id = _loc5_;
            _loc4_.gotoAndStop(1);
            _loc4_.sel = false;
            _loc4_.onRollOver = function()
            {
               if(!this.sel)
               {
                  Prince3.PrinceSystem.actionCapture(this,"onRollOver");
                  this.gotoAndStop(2);
               }
            };
            _loc4_.onRollOut = _loc4_.onReleaseOutside = function()
            {
               if(!this.sel)
               {
                  Prince3.PrinceSystem.actionCapture(this,"onReleaseOutside");
                  this.gotoAndStop(1);
               }
            };
            _loc4_.onRelease = function()
            {
               var _loc2_ = 1;
               var _loc3_;
               while(_loc2_ <= 6)
               {
                  _loc3_ = this._parent["mc_lv" + _loc2_];
                  if(_loc3_.sel && this.id != _loc2_)
                  {
                     _loc3_.sel = false;
                     _loc3_.gotoAndStop(1);
                     break;
                  }
                  _loc2_ = _loc2_ + 1;
               }
               if(!this.sel)
               {
                  this.sel = true;
                  this._parent.lv = this._name.substr(5);
                  Prince3.PrinceSystem.actionCapture(this,"onRelease");
               }
            };
            _loc5_ = _loc5_ + 1;
         }
         _loc6_.lv = _loc8_.classLv;
         _loc6_["mc_lv" + _loc6_.lv].sel = true;
         _loc6_["mc_lv" + _loc6_.lv].gotoAndStop(2);
         _loc6_.btn_edit.onRollOut = _loc6_.btn_edit.onReleaseOutside = this.btnOnRollOut;
         _loc6_.btn_edit.onRollOver = this.btnOnRollOver;
         _loc6_.btn_edit.onPress = this.btnOnPress;
         _loc6_.btn_edit.onRelease = function()
         {
            if(this._parent.txt.text)
            {
               Prince3.PrinceSystem.updateUserInfo(this._parent._parent.sel,this._parent.txt.text,this._parent.lv);
               this._parent._parent.loginPageInit();
            }
         };
         _loc6_.btn_cancel.onRollOut = _loc6_.btn_cancel.onReleaseOutside = this.btnOnRollOut;
         _loc6_.btn_cancel.onRollOver = this.btnOnRollOver;
         _loc6_.btn_cancel.onPress = this.btnOnPress;
         _loc6_.btn_cancel.onRelease = function()
         {
            this._parent._parent.loginPageInit();
         };
         this.btn_del._visible = false;
         this.btn_edit._visible = false;
         this.btn_login._visible = false;
         _loc7_ = 0;
         while(_loc7_ < 6)
         {
            this["mc_slot" + _loc7_].enabled = false;
            _loc7_ = _loc7_ + 1;
         }
      }
   }
   function selAccount(id)
   {
      var _loc6_;
      var _loc7_;
      var _loc5_;
      if(this.sel != null)
      {
         _loc6_ = this["mc_slot" + this.sel];
         if(_loc6_._currentframe == 2)
         {
            _loc6_.gotoAndStop(1);
         }
         else if(_loc6_._currentframe == 4)
         {
            _loc6_.gotoAndStop(3);
            _loc7_ = Prince3.PrinceSystem.getUser(this.sel);
            _loc6_.txt.text = _loc7_.userName;
            _loc6_.score = _loc7_.score;
            _loc6_.classlevel = _loc7_.classLv;
            _loc5_ = 0;
            while(_loc5_ < 5)
            {
               _loc6_["gem" + _loc5_] = Prince3.Utils.num2Str(Prince3.Utils.numLimit(_loc7_.gems[_loc5_],0,99),10,0);
               _loc5_ = _loc5_ + 1;
            }
         }
         _loc6_.mc_sel._visible = false;
         _loc6_.mc_sel.gotoAndStop(1);
         _loc6_.onPress = function()
         {
            Prince3.PrinceSystem.actionCapture(this,"onRelease");
            this._parent.selAccount(this.id);
         };
         _loc6_.onRollOver = function()
         {
            if(!this.mc_sel._visible)
            {
               this.mc_sel._visible = true;
               this.mc_sel.gotoAndStop(1);
            }
         };
         _loc6_.onRollOut = function()
         {
            if(this.mc_sel._visible && this.mc_sel._currentframe == 1)
            {
               this.mc_sel._visible = false;
               this.mc_sel.gotoAndStop(1);
            }
         };
      }
      this.btn_del._visible = false;
      this.btn_edit._visible = false;
      this.btn_login._visible = false;
      this.sel = id;
      _loc6_ = this["mc_slot" + id];
      _loc6_.mc_sel._visible = true;
      _loc6_.mc_sel.gotoAndStop(2);
      delete _loc6_.onRelease;
      delete _loc6_.onRollOver;
      delete _loc6_.onRollOut;
      delete _loc6_.onPress;
      var _loc4_;
      if(_loc6_._currentframe == 1)
      {
         _loc6_.gotoAndStop(2);
         _loc6_.txt.text = "";
         _loc5_ = 1;
         while(_loc5_ <= 6)
         {
            _loc4_ = _loc6_["mc_lv" + _loc5_];
            _loc4_.id = _loc5_;
            _loc4_.gotoAndStop(1);
            _loc4_.sel = false;
            _loc4_.onRollOver = function()
            {
               if(!this.sel)
               {
                  Prince3.PrinceSystem.actionCapture(this,"onRollOver");
                  this.gotoAndStop(2);
               }
            };
            _loc4_.onRollOut = _loc4_.onReleaseOutside = function()
            {
               if(!this.sel)
               {
                  Prince3.PrinceSystem.actionCapture(this,"onReleaseOutside");
                  this.gotoAndStop(1);
               }
            };
            _loc4_.onRelease = function()
            {
               var _loc2_ = 1;
               var _loc3_;
               while(_loc2_ <= 6)
               {
                  _loc3_ = this._parent["mc_lv" + _loc2_];
                  if(_loc3_.sel && this.id != _loc2_)
                  {
                     _loc3_.sel = false;
                     _loc3_.gotoAndStop(1);
                     break;
                  }
                  _loc2_ = _loc2_ + 1;
               }
               if(!this.sel)
               {
                  this.sel = true;
                  this._parent.lv = this._name.substr(5);
                  Prince3.PrinceSystem.actionCapture(this,"onRelease");
               }
            };
            _loc5_ = _loc5_ + 1;
         }
         _loc6_.lv = 1;
         _loc6_.mc_lv1.sel = true;
         _loc6_.mc_lv1.gotoAndStop(2);
         _loc6_.btn_ok.onRollOut = _loc6_.btn_ok.onReleaseOutside = this.btnOnRollOut;
         _loc6_.btn_ok.onRollOver = this.btnOnRollOver;
         _loc6_.btn_ok.onPress = this.btnOnPress;
         _loc6_.btn_ok.onRelease = function()
         {
            if(this._parent.txt.text)
            {
               Prince3.PrinceSystem.addUser(this._parent._parent.sel,this._parent.txt.text,1,"none",1,this._parent.lv,"none");
               this._parent._parent.loginPageInit();
            }
         };
         _loc6_.btn_cancel.onRollOut = _loc6_.btn_cancel.onReleaseOutside = this.btnOnRollOut;
         _loc6_.btn_cancel.onRollOver = this.btnOnRollOver;
         _loc6_.btn_cancel.onPress = this.btnOnPress;
         _loc6_.btn_cancel.onRelease = function()
         {
            this._parent._parent.sel = null;
            this._parent._parent.loginPageInit();
         };
         Selection.setFocus(_loc6_.txt);
      }
      else
      {
         this.btn_del._visible = true;
         this.btn_edit._visible = true;
         this.btn_login._visible = true;
      }
   }
}
