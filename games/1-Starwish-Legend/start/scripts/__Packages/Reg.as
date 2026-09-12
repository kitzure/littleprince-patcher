class Reg
{
   static var _firstcall;
   static var _licence;
   static var _network;
   static var intervalID;
   static var loadingSWF;
   static var lv_net;
   static var princeService_nc;
   static var timeoutID;
   function Reg()
   {
   }
   static function init(obj)
   {
      Reg._firstcall = true;
      Reg.loadingSWF = obj;
      Reg.lv_net = new LoadVars();
      Reg.lv_net.onHTTPStatus = Reg.onHTTPStatus;
      Reg.updateNetwork();
   }
   static function updateNetwork()
   {
      Reg.intervalID = setInterval(Reg.checkNetworkTimeout,5000);
      Reg.lv_net.load("http://www.little-prince.com.hk/littleprince/amfservice/gateway.php");
   }
   static function checkNetworkTimeout()
   {
      Reg.onHTTPStatus(0);
   }
   static function onHTTPStatus(httpStatus)
   {
      clearInterval(Reg.intervalID);
      Reg.intervalID = null;
      Reg._network = httpStatus == 200;
      if(Reg._firstcall == true)
      {
         Reg._firstcall = false;
         SaveLoadSystem.root.loadRegSWF();
      }
   }
   static function onLoadInit(target_mc)
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      Reg.loadingSWF.target.play();
      Reg._licence = SaveLoadSystem.loadLicence();
      Reg.checkActivation();
   }
   static function checkActivation()
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      if(Reg._licence.activationKey != "")
      {
         if(Reg.getHDKey() == Reg._licence.hdkey)
         {
            if(Reg.activationSuccess(Reg._licence.sn,Reg._licence.hdkey,Reg._licence.activationKey))
            {
               if(Reg.haveNetwork())
               {
                  _loc1_.Username = Reg._licence.name;
                  _loc1_.Phone = Reg._licence.phone;
                  _loc1_.Email = Reg._licence.email;
                  _loc1_.Serial = Reg._licence.sn;
                  if(!Reg.serviceRequest([{type:"checkActivation",name:Reg._licence.name,phone:Reg._licence.phone,email:Reg._licence.email,rkey:Reg.requestKey(Reg._licence.sn,Reg._licence.hdkey)}]))
                  {
                     SaveLoadSystem.root.loadFullVersion();
                  }
                  else
                  {
                     Reg.initTimeOutCount();
                     _loc1_.popup("loading",[_loc1_.btn_activate]);
                  }
               }
               else
               {
                  SaveLoadSystem.root.loadFullVersion();
               }
            }
            else
            {
               _loc1_.gotoAndStop("activated");
               Reg.clearActivation();
               _loc1_.popup("e060",[_loc1_.btn_activate]);
            }
         }
         else
         {
            _loc1_.gotoAndStop("activated");
            Reg.clearActivation();
            _loc1_.popup("e090",[_loc1_.btn_activate]);
            _loc1_.mc_popup.error = "090";
         }
      }
      else
      {
         _loc1_.gotoAndStop("form");
         _loc1_.popup("loading",[_loc1_.btn_activate]);
         if(!Reg.serviceRequest([{type:"checkVersion"}]))
         {
            Reg.checkVersionResponse(Number(_loc1_._root.verNumber));
         }
         else
         {
            Reg.initTimeOutCount();
         }
      }
   }
   static function connectActivationServer()
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      var _loc4_ = _loc1_.Username;
      var _loc5_ = _loc1_.Phone;
      var _loc6_ = _loc1_.Email;
      var _loc3_ = _loc1_.Serial;
      var _loc2_ = Reg.getHDKey();
      if(_loc2_.indexOf("-") != 4)
      {
         _loc1_.popup("e010",[_loc1_.btn_activate]);
      }
      else if(!Reg.haveNetwork())
      {
         _loc1_.popup("e020",[_loc1_.btn_activate]);
      }
      else if(!Reg.serviceRequest([{type:"activation",name:_loc4_,phone:_loc5_,email:_loc6_,rkey:Reg.requestKey(_loc3_,_loc2_)}]))
      {
         _loc1_.popup("e030",[_loc1_.btn_activate]);
      }
      else
      {
         Reg.initTimeOutCount();
         _loc1_.popup("loading",[_loc1_.btn_activate]);
      }
   }
   static function activationResponse(result)
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      Reg.clearTimeOutCount();
      var _loc3_ = Reg.getHDKey();
      if(result == "e040")
      {
         _loc1_.popup("e040",[_loc1_.btn_activate]);
      }
      else if(result == "e050")
      {
         _loc1_.popup("e050",[_loc1_.btn_activate]);
      }
      else if(result == "e080")
      {
         _loc1_.gotoAndStop("activated");
         _loc1_.popup("e080",[_loc1_.btn_activate]);
      }
      else if(!Reg.activationSuccess(_loc1_.Serial,_loc3_,result))
      {
         if(_loc1_.alert_act)
         {
            _loc1_.alert_act.gotoAndPlay("a2");
         }
         else
         {
            _loc1_.gotoAndStop("activated");
            Reg.clearActivation();
            _loc1_.popup("e090",[_loc1_.btn_activate]);
         }
      }
      else
      {
         _loc1_.killPopup();
         Reg.saveActivation(_loc1_.Username,_loc1_.Phone,_loc1_.Email,_loc1_.Serial,_loc3_,result);
         _loc1_.gotoAndStop("success");
      }
   }
   static function reactivation()
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      var _loc4_ = _loc1_.Username;
      var _loc5_ = _loc1_.Phone;
      var _loc6_ = _loc1_.Email;
      var _loc2_ = _loc1_.Serial;
      var _loc3_ = Reg.getHDKey();
      Reg.serviceRequest([{type:"reactivation",name:_loc4_,phone:_loc5_,email:_loc6_,rkey:Reg.requestKey(_loc2_,_loc3_)}]);
      Reg.initTimeOutCount();
   }
   static function reactivationResponse(result)
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      Reg.clearTimeOutCount();
      trace("result: " + result);
      var _loc3_ = Reg.getHDKey();
      if(result == "a055")
      {
         _loc1_.mc_popup.gotoAndStop(_loc1_.mc_popup.last);
         _loc1_.mc_popup.mc_al_phone.gotoAndPlay("a2");
         _loc1_.mc_popup.mc_al_email.gotoAndPlay("a3");
      }
      else if(result == "e080")
      {
         _loc1_.gotoAndStop("activated");
         _loc1_.popup("e080",[_loc1_.btn_activate]);
      }
      else
      {
         _loc1_.killPopup();
         Reg.saveActivation(_loc1_.Username,_loc1_.Phone,_loc1_.Email,_loc1_.Serial,_loc3_,result);
         _loc1_.gotoAndStop("success");
      }
   }
   static function checkActivationResponse(result)
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      Reg.clearTimeOutCount();
      trace("result: " + result);
      if(result == "e091")
      {
         _loc1_.gotoAndStop("activated");
         Reg.clearActivation();
         _loc1_.popup("e090",[_loc1_.btn_activate]);
         _loc1_.mc_popup.error = "091";
      }
      else if(result == "e070")
      {
         _loc1_.gotoAndStop("activated");
         _loc1_.popup("e070",[_loc1_.btn_activate]);
      }
      else if(result == "e080")
      {
         _loc1_.gotoAndStop("activated");
         _loc1_.popup("e080",[_loc1_.btn_activate]);
      }
      else
      {
         _loc1_.killPopup();
         SaveLoadSystem.root.loadFullVersion();
      }
   }
   static function checkVersionResponse(ver)
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      Reg.clearTimeOutCount();
      ver = String(ver);
      ver = ver.split(",")[0];
      if(Number(ver) > Number(_loc1_._root.verNumber))
      {
         _loc1_.popup("e000",[_loc1_.btn_activate]);
      }
      else
      {
         _loc1_.killPopup();
      }
   }
   static function haveNetwork()
   {
      if(!Reg._network)
      {
         return false;
      }
      return SaveLoadSystem.root.haveNetwork();
   }
   static function getHDKey()
   {
      return SaveLoadSystem.root.getHDKey();
   }
   static function clearActivation()
   {
      Reg._licence.name = "";
      Reg._licence.phone = "";
      Reg._licence.email = "";
      Reg._licence.sn = "";
      Reg._licence.hdkey = "";
      Reg._licence.activationKey = "";
      SaveLoadSystem.saveLicence(Reg._licence);
   }
   static function saveActivation(name, phone, email, sn, hdkey, akey)
   {
      Reg._licence.name = name;
      Reg._licence.phone = phone;
      Reg._licence.email = email;
      Reg._licence.sn = sn;
      Reg._licence.hdkey = hdkey;
      Reg._licence.activationKey = akey;
      SaveLoadSystem.saveLicence(Reg._licence);
   }
   static function serviceRequest(data)
   {
      var _loc1_ = new Object();
      _loc1_.onResult = Reg.serviceResponse;
      Reg.princeService_nc = new NetConnection();
      if(Reg.haveNetwork())
      {
         Reg.princeService_nc.connect("http://www.little-prince.com.hk/littleprince/amfservice/gateway.php");
         Reg.princeService_nc.call("Prince2_v2_2.serviceRequest",_loc1_,data);
         return true;
      }
      return false;
   }
   static function serviceResponse(val)
   {
      if(val)
      {
         if(val.response == "checkVersionResult")
         {
            Reg.checkVersionResponse(val.message);
         }
         else if(val.response == "activationResult")
         {
            Reg.activationResponse(val.message);
         }
         else if(val.response == "reactivationResult")
         {
            Reg.reactivationResponse(val.message);
         }
         else if(val.response == "checkActivationResult")
         {
            Reg.checkActivationResponse(val.message);
         }
      }
   }
   static function initTimeOutCount()
   {
      Reg.timeoutID = setInterval(Reg.timeOutAppear,5000);
   }
   static function timeOutAppear()
   {
      var _loc1_ = SaveLoadSystem.root.reg;
      _loc1_.popup("e020",[_loc1_.btn_activate]);
      Reg.clearTimeOutCount();
   }
   static function clearTimeOutCount()
   {
      clearInterval(Reg.timeoutID);
      Reg.timeoutID = null;
   }
   static function hdkey2Nums(str)
   {
      str = str.split("-").join("");
      var _loc3_ = "pL]51?m;iFvZ<.SsrR$^}H!a+eGyjf[gOC`b-lYE&)w=:dN306hqkA|PD9{>(%nK#4*xtBuWMQV~7Tz2\'8@J_,XIUco".split("");
      var _loc6_ = ["97","39","91","14","00","41","93","72","01","18","68","48","99","85","81","19","63","11","54","45","57","23","51","89","40","28","16","25","20","92","98","29","83","50","80","74","94","38","47","37","87","22","27","10","05","24","30","52","77","61","26","60","34","46","73","84","07","59","78","12","69","82","36","35","21","15","67","03","31","43","33","09","75","08","04","56","53","32","13","90","02","96","55","71","88","58","06","95","86","66","42","64","65","79","76","17","49","70","62","44"];
      var _loc5_ = "";
      var _loc2_ = 0;
      var _loc1_;
      while(_loc2_ < str.length)
      {
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            if(str.substr(_loc2_,1) == _loc3_[_loc1_])
            {
               _loc5_ += _loc6_[_loc1_];
               break;
            }
            _loc1_ = _loc1_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   static function nums2hdkey(str)
   {
      str = str.split("-").join("");
      var _loc6_ = "pL]51?m;iFvZ<.SsrR$^}H!a+eGyjf[gOC`b-lYE&)w=:dN306hqkA|PD9{>(%nK#4*xtBuWMQV~7Tz2\'8@J_,XIUco".split("");
      var _loc3_ = ["97","39","91","14","00","41","93","72","01","18","68","48","99","85","81","19","63","11","54","45","57","23","51","89","40","28","16","25","20","92","98","29","83","50","80","74","94","38","47","37","87","22","27","10","05","24","30","52","77","61","26","60","34","46","73","84","07","59","78","12","69","82","36","35","21","15","67","03","31","43","33","09","75","08","04","56","53","32","13","90","02","96","55","71","88","58","06","95","86","66","42","64","65","79","76","17","49","70","62","44"];
      var _loc5_ = "";
      var _loc2_ = 0;
      var _loc1_;
      while(_loc2_ < str.length)
      {
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            if(str.substr(_loc2_,2) == _loc3_[_loc1_])
            {
               _loc5_ += _loc6_[_loc1_];
               break;
            }
            _loc1_ = _loc1_ + 1;
         }
         _loc2_ += 2;
      }
      return _loc5_.substr(0,4) + "-" + _loc5_.substr(4,4);
   }
   static function serial2Nums(str)
   {
      str = str.split("-");
      str.shift();
      str = str.join("");
      var _loc7_ = "F9E5K3P4JMAXV6R82C17YTQ0S".split("");
      var _loc6_ = "";
      var _loc1_ = 0;
      var _loc3_ = 0;
      var _loc4_;
      var _loc2_;
      while(_loc3_ < str.length)
      {
         _loc4_ = str.substr(_loc3_,1);
         _loc2_ = 0;
         while(_loc2_ < 25)
         {
            if(_loc7_[_loc1_] == _loc4_)
            {
               _loc6_ += _loc2_;
               break;
            }
            _loc1_ = _loc1_ - 1;
            while(_loc1_ < 0)
            {
               _loc1_ += 25;
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc1_ -= 11;
         while(_loc1_ < 0)
         {
            _loc1_ += 25;
         }
         _loc3_ += 1;
      }
      return _loc6_;
   }
   static function str2Int(str)
   {
      var _loc2_ = 0;
      var _loc1_ = 0;
      while(_loc1_ < str.length)
      {
         _loc2_ = _loc2_ * 10 + int(str.substr(_loc1_,1));
         _loc1_ = _loc1_ + 1;
      }
      return _loc2_;
   }
   static function checksum(str)
   {
      var _loc3_ = 0;
      var _loc1_ = 0;
      while(_loc1_ < str.length)
      {
         _loc3_ += Reg.str2Int(str.substr(_loc1_,4));
         _loc1_ += 4;
      }
      return String(_loc3_ % 10);
   }
   static function encrypt(str)
   {
      var _loc6_ = "2965130847";
      var _loc5_ = "";
      var _loc1_ = 0;
      var _loc3_ = 0;
      var _loc4_;
      var _loc2_;
      while(_loc3_ < str.length)
      {
         _loc4_ = str.substr(_loc3_,1);
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            if(_loc6_.substr(_loc1_,1) == _loc4_)
            {
               _loc5_ += _loc2_;
               break;
            }
            _loc1_ = _loc1_ - 1;
            while(_loc1_ < 0)
            {
               _loc1_ += 10;
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc1_ -= _loc2_;
         _loc1_ -= 3;
         while(_loc1_ < 0)
         {
            _loc1_ += 10;
         }
         _loc3_ += 1;
      }
      return _loc5_;
   }
   static function decrypt(str)
   {
      var _loc5_ = "2965130847";
      var _loc4_ = "";
      var _loc1_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < str.length)
      {
         _loc1_ -= str.substr(_loc2_,1);
         while(_loc1_ < 0)
         {
            _loc1_ += 10;
         }
         _loc4_ += _loc5_.substr(_loc1_,1);
         _loc1_ -= int(str.substr(_loc2_,1));
         _loc1_ -= 3;
         while(_loc1_ > 9)
         {
            _loc1_ -= 10;
         }
         _loc2_ += 1;
      }
      return _loc4_;
   }
   static function requestKey(sn, hdkey)
   {
      var _loc2_;
      if(sn.indexOf("P2-") == 0)
      {
         _loc2_ = Reg.serial2Nums(sn) + Reg.hdkey2Nums(hdkey);
         return "P2-" + Reg.encrypt(Reg.checksum(_loc2_) + _loc2_);
      }
      return sn + "," + hdkey + "," + SaveLoadSystem.root.mdm.Encryption.encryptString("SIEdutainment","|=_=|" + hdkey + "|=_=|" + sn);
   }
   static function activationSuccess(sn, hdkey, akey)
   {
      var _loc2_;
      if(akey.length == 16)
      {
         _loc2_ = Reg.serial2Nums(sn);
         if(_loc2_.length != 16)
         {
            return false;
         }
         return hdkey == Reg.nums2hdkey(Reg.decrypt(Reg.encrypt(Reg.checksum(_loc2_)) + akey).substr(1,16));
      }
      akey = SaveLoadSystem.root.mdm.Encryption.decryptString("SIEdutainment",akey).split("|=_=|");
      return hdkey == akey[1] && sn == akey[2];
   }
}
