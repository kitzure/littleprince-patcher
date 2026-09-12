class Application extends MovieClip
{
   var bmp;
   var content;
   var intervalID;
   var loading;
   var lv_net;
   var mc_blur;
   var timeout;
   function Application()
   {
      super();
      this.timeout = 0;
      Prince3.PrinceSystem.application = this;
   }
   function onLoad()
   {
      trace("in");
      this.mc_blur._visible = false;
      this.bmp = new flash.display.BitmapData(800,600,false,255);
      this.mc_blur.attachBitmap(this.bmp,1);
      _root._firstcall = true;
      _root._network = false;
      this.lv_net = new LoadVars();
      this.lv_net.onHTTPStatus = mx.utils.Delegate.create(this,this.onHTTPStatus);
      _root.updateNetwork = this.updateNetwork;
      this.updateNetwork();
   }
   function onHTTPStatus(httpStatus)
   {
      trace(">>>>>>>");
      clearInterval(this.intervalID);
      this.intervalID = null;
      if(httpStatus == 200)
      {
         _root._network = true;
      }
      else
      {
         _root._network = false;
      }
      if(_root._firstcall == true)
      {
         _root._firstcall = false;
         Prince3.PrinceSystem.loadReg();
      }
   }
   function updateNetwork()
   {
      this.intervalID = setInterval(mx.utils.Delegate.create(this,this.checkNetworkTimeout),5000);
      this.lv_net.load("http://www.little-prince.com.hk/littleprince/amfservice/gateway.php");
   }
   function checkNetworkTimeout()
   {
      this.onHTTPStatus(0);
   }
   function onEnterFrame()
   {
      if(this.timeout)
      {
         this.timeout = this.timeout - 1;
         if(this.timeout == 0)
         {
            this.content.popup("e020",[this.content.btn_activate]);
         }
      }
      Prince3.PrinceSystem.keyUpdate();
   }
   function initTimeOutCount()
   {
      this.timeout = 240;
   }
   function checkActivation()
   {
      var _loc3_ = _root.loadSO();
      if(_loc3_.data.activationKey)
      {
         if(_root.getHDKey() == _loc3_.data.hdkey)
         {
            if(_root.activationSuccess(_loc3_.data.sn,_loc3_.data.hdkey,_loc3_.data.activationKey))
            {
               if(_root.haveNetwork())
               {
                  this.loading._visible = true;
                  this.content.Username = _loc3_.data.name;
                  this.content.Phone = _loc3_.data.phone;
                  this.content.Email = _loc3_.data.email;
                  this.content.Serial = _loc3_.data.sn;
                  if(!Prince3.PrinceSystem.serviceRequest([{type:"checkActivation",name:_loc3_.data.name,phone:_loc3_.data.phone,email:_loc3_.data.email,rkey:_root.requestKey(_loc3_.data.sn,_loc3_.data.hdkey)}]))
                  {
                     Prince3.PrinceSystem.loadOpening();
                  }
                  else
                  {
                     this.initTimeOutCount();
                     this.content.popup("loading",[this.content.btn_activate]);
                  }
               }
               else
               {
                  Prince3.PrinceSystem.loadOpening();
               }
            }
            else
            {
               this.content.gotoAndStop("activated");
               _root.clearActivation();
               this.content.popup("e060",[this.content.btn_activate]);
            }
         }
         else
         {
            this.content.gotoAndStop("activated");
            _root.clearActivation();
            this.content.popup("e090",[this.content.btn_activate]);
            this.content.mc_popup.error = "090";
         }
      }
      else
      {
         this.content.gotoAndStop("form");
         this.content.popup("loading",[this.content.btn_activate]);
         if(!Prince3.PrinceSystem.serviceRequest([{type:"checkVersion"}]))
         {
            this.checkVersionResponse(Number(_root.verNumber));
         }
         else
         {
            this.initTimeOutCount();
         }
      }
   }
   function connectActivationServer()
   {
      var _loc5_ = this.content.Username;
      var _loc6_ = this.content.Phone;
      var _loc7_ = this.content.Email;
      var _loc4_ = this.content.Serial;
      var _loc3_ = _root.getHDKey();
      if(_loc3_.indexOf("-") != 4)
      {
         this.content.popup("e010",[this.content.btn_activate]);
      }
      else if(!_root.haveNetwork())
      {
         this.content.popup("e020",[this.content.btn_activate]);
      }
      else if(!Prince3.PrinceSystem.serviceRequest([{type:"activation",name:_loc5_,phone:_loc6_,email:_loc7_,rkey:_root.requestKey(_loc4_,_loc3_)}]))
      {
         this.content.popup("e030",[this.content.btn_activate]);
      }
      else
      {
         this.initTimeOutCount();
         this.content.popup("loading",[this.content.btn_activate]);
      }
   }
   function activationResponse(result)
   {
      this.timeout = 0;
      trace("result: " + result);
      var _loc4_ = _root.getHDKey();
      if(result == "e040")
      {
         this.content.popup("e040",[this.content.btn_activate]);
      }
      else if(result == "e050")
      {
         this.content.popup("e050",[this.content.btn_activate]);
      }
      else if(result == "e080")
      {
         this.content.gotoAndStop("activated");
         this.content.popup("e080",[this.content.btn_activate]);
      }
      else if(!_root.activationSuccess(this.content.Serial,_loc4_,result))
      {
         if(this.content.alert_act)
         {
            this.content.alert_act.gotoAndPlay("a2");
         }
         else
         {
            this.content.gotoAndStop("activated");
            _root.clearActivation();
            this.content.popup("e090",[this.content.btn_activate]);
         }
      }
      else
      {
         this.content.killPopup();
         _root.saveActivation(this.content.Username,this.content.Phone,this.content.Email,this.content.Serial,_loc4_,result);
         this.content.gotoAndStop("success");
      }
   }
   function reactivation()
   {
      var _loc5_ = this.content.Username;
      var _loc6_ = this.content.Phone;
      var _loc7_ = this.content.Email;
      var _loc3_ = this.content.Serial;
      var _loc4_ = _root.getHDKey();
      Prince3.PrinceSystem.serviceRequest([{type:"reactivation",name:_loc5_,phone:_loc6_,email:_loc7_,rkey:_root.requestKey(_loc3_,_loc4_)}]);
      this.initTimeOutCount();
   }
   function reactivationResponse(result)
   {
      this.timeout = 0;
      trace("result: " + result);
      var _loc4_ = _root.getHDKey();
      if(result == "a055")
      {
         this.content.mc_popup.gotoAndStop(this.content.mc_popup.last);
         this.content.mc_popup.mc_al_phone.gotoAndPlay("a2");
         this.content.mc_popup.mc_al_email.gotoAndPlay("a3");
      }
      else if(result == "e080")
      {
         this.content.gotoAndStop("activated");
         this.content.popup("e080",[this.content.btn_activate]);
      }
      else
      {
         this.content.killPopup();
         _root.saveActivation(this.content.Username,this.content.Phone,this.content.Email,this.content.Serial,_loc4_,result);
         this.content.gotoAndStop("success");
      }
   }
   function checkActivationResponse(result)
   {
      this.timeout = 0;
      trace("result: " + result);
      this.loading._visible = false;
      if(result == "e091")
      {
         this.content.gotoAndStop("activated");
         _root.clearActivation();
         this.content.popup("e090",[this.content.btn_activate]);
         this.content.mc_popup.error = "091";
      }
      else if(result == "e070")
      {
         this.content.gotoAndStop("activated");
         this.content.popup("e070",[this.content.btn_activate]);
      }
      else if(result == "e080")
      {
         this.content.gotoAndStop("activated");
         this.content.popup("e080",[this.content.btn_activate]);
      }
      else
      {
         this.content.killPopup();
         Prince3.PrinceSystem.loadOpening();
      }
   }
   function checkVersionResponse(ver)
   {
      this.timeout = 0;
      ver = ver.split(",")[0];
      trace("version: " + ver);
      if(Number(ver) > Number(_root.verNumber))
      {
         this.content.popup("e000",[this.content.btn_activate]);
      }
      else
      {
         this.content.killPopup();
      }
   }
   function trial()
   {
      _root.mc_trial._visible = true;
      Prince3.PrinceSystem.loadOpening();
      Prince3.PrinceSystem.users = new Array(6);
      Prince3.PrinceSystem.addUser(0,"DEMO",1,"DEMO",1,1,"none");
   }
   function onMouseDown()
   {
      Prince3.PrinceSystem.onMouseDown();
   }
   function onMouseUp()
   {
      Prince3.PrinceSystem.onMouseUp();
   }
   function onMouseMove()
   {
      Prince3.PrinceSystem.onMouseMove();
   }
}
