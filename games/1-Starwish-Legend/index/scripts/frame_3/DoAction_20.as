function checkRegInfo()
{
   traceOut("checkRegInfo()");
   var my_so = SharedObject.getLocal("prince2set","/");
   var _loc3_ = mdm.Network.checkConnection();
   var licMode = "";
   if(my_so.data.regInfo == undefined)
   {
      my_so.data.regInfo = new Object();
      my_so.data.regInfo.numNotConnect = 0;
      my_so.data.regInfo.k1 = "";
      var _loc4_ = mdm.System.getHDSerial(regInfo.getHD());
      my_so.data.regInfo.k2 = _loc4_.toUpperCase();
      my_so.data.regInfo.k3 = "";
      my_so.data.regInfo.username = "";
      my_so.data.regInfo.phone = "";
      my_so.data.regInfo.hkid = "";
      my_so.data.regInfo.email = "";
      my_so.data.regInfo.address = "";
      var _loc1_ = new Date();
      var _loc7_ = _loc1_.getFullYear();
      var _loc5_ = _loc1_.getMonth() >= 10 ? _loc1_.getMonth() : "0" + _loc1_.getMonth();
      var _loc6_ = _loc1_.getDate() >= 10 ? _loc1_.getDate() : "0" + _loc1_.getDate();
      var _loc10_ = _loc1_.getHours() >= 10 ? _loc1_.getHours() : "0" + _loc1_.getHours();
      var _loc11_ = _loc1_.getMinutes() >= 10 ? _loc1_.getMinutes() : "0" + _loc1_.getMinutes();
      var _loc8_ = _loc1_.getSeconds() >= 10 ? _loc1_.getSeconds() : "0" + _loc1_.getSeconds();
      var _loc9_ = _loc1_.getMilliseconds() >= 10 ? (_loc1_.getMilliseconds() >= 100 ? _loc1_.getMilliseconds() : "0" + _loc1_.getMilliseconds()) : "00" + _loc1_.getMilliseconds();
      my_so.data.regInfo.d1 = _loc7_ + "" + _loc5_ + "" + _loc6_ + "" + _loc10_ + "" + _loc11_ + "" + _loc8_ + "" + _loc9_;
      licMode = "noKeyS";
      my_so.flush();
      regIsChecked(licMode);
   }
   else if(my_so.data.regInfo.k1 == "" || my_so.data.regInfo.k1 == undefined)
   {
      licMode = "noKeyS";
      my_so.flush();
      regIsChecked(licMode);
   }
   else if(my_so.data.regInfo.k3 == "" || my_so.data.regInfo.k3 == undefined)
   {
      licMode = "noKeyA";
      my_so.flush();
      regIsChecked(licMode);
   }
   else
   {
      traceOut("hasNetwork:" + _loc3_);
      if(_loc3_)
      {
         var result_lv = new LoadVars();
         var _loc2_ = new LoadVars();
         _loc2_.k1 = my_so.data.regInfo.k1;
         _loc2_.k2 = my_so.data.regInfo.k2;
         _loc2_.k3 = my_so.data.regInfo.k3;
         _loc2_.d1 = my_so.data.regInfo.d1;
         _loc2_.username = my_so.data.regInfo.username;
         _loc2_.phone = my_so.data.regInfo.phone;
         _loc2_.hkid = my_so.data.regInfo.hkid;
         _loc2_.email = my_so.data.regInfo.email;
         _loc2_.address = my_so.data.regInfo.address;
         if(my_so.data.regInfo.k2 == mdm.System.getHDSerial(regInfo.getHD()).toUpperCase() && my_so.data.regInfo.k3 == createKey(regInfo.getKeyACS()[0],regInfo.getKeyACS()[1],my_so.data.regInfo.k1,my_so.data.regInfo.k2,my_so.data.regInfo.d1))
         {
            _loc2_.sendAndLoad(regInfo.getKeyAPath(),result_lv,"POST");
            result_lv.onLoad = function(success)
            {
               if(success)
               {
                  my_so.data.regInfo.numNotConnect = 0;
                  if(result_lv.valid == "true" || result_lv.valid == true)
                  {
                     licMode = "fullcd";
                  }
                  else if(result_lv.valid == "false" || result_lv.valid == false)
                  {
                     licMode = "noKeyS";
                     my_so.data.regInfo.k1 = "";
                     my_so.data.regInfo.k3 = "";
                  }
                  else
                  {
                     licMode = "noKeyA";
                     my_so.data.regInfo.k1 = "";
                     my_so.data.regInfo.k3 = "";
                  }
                  my_so.flush();
                  regIsChecked(licMode);
               }
               else
               {
                  if(my_so.data.regInfo.numNotConnect == undefined)
                  {
                     my_so.data.regInfo.numNotConnect = 1;
                  }
                  else if(my_so.data.regInfo.numNotConnect >= 0)
                  {
                     my_so.data.regInfo.numNotConnect += 1;
                  }
                  licMode = "fullcd";
                  my_so.flush();
                  regIsChecked(licMode);
               }
            };
         }
         else
         {
            licMode = "noKeyS";
            my_so.flush();
            regIsChecked(licMode);
         }
      }
      else
      {
         traceOut("my_so.data.regInfo.numNotConnect 1:" + my_so.data.regInfo.numNotConnect);
         if(my_so.data.regInfo.numNotConnect == undefined)
         {
            my_so.data.regInfo.numNotConnect = 1;
         }
         else if(my_so.data.regInfo.numNotConnect >= 0)
         {
            my_so.data.regInfo.numNotConnect += 1;
         }
         traceOut("my_so.data.regInfo.numNotConnect 2:" + my_so.data.regInfo.numNotConnect);
         if(my_so.data.regInfo.numNotConnect > 10)
         {
            licMode = "fullcd";
            traceOut("my_so.data.regInfo.numNotConnect 2:" + my_so.data.regInfo.numNotConnect);
            my_so.flush();
            regIsChecked(licMode);
         }
         else
         {
            licMode = "fullcd";
            my_so.flush();
            regIsChecked(licMode);
         }
      }
   }
}
function regIsChecked(agLicMode)
{
   var _loc2_ = null;
   var _loc3_;
   if((_loc2_ = agLicMode) !== "fullcd")
   {
      _loc3_ = SharedObject.getLocal("prince2set","/");
      _loc3_.data.userList = new Array();
      reg.loadMovie("reg.swf");
   }
   else
   {
      loadFullVersion();
   }
}
function activateProduct(agSerialNum, agUsername, agPhone, agEmail, agHKID, agAddress)
{
   if(agUsername == "" || agPhone == "" || agEmail == "")
   {
      reg.popup.nextPage = "";
      reg.popup._visible = true;
      reg.popup.gotoAndStop("noInfo");
      return false;
   }
   if((agUsername + agPhone + agEmail + agHKID + agAddress).indexOf("\r") >= 0)
   {
      reg.popup.nextPage = "";
      reg.popup._visible = true;
      reg.popup.gotoAndStop("oneline");
      return false;
   }
   if(isNaN(agPhone))
   {
      reg.popup.nextPage = "";
      reg.popup._visible = true;
      reg.popup.gotoAndStop("badPhone");
      return false;
   }
   if(agSerialNum == "")
   {
      reg.popup.nextPage = "";
      reg.popup._visible = true;
      reg.popup.gotoAndStop("badSerial");
      return false;
   }
   var my_so = SharedObject.getLocal("prince2set","/");
   my_so.data.regInfo.k1 = agSerialNum.toUpperCase();
   my_so.data.regInfo.username = agUsername;
   my_so.data.regInfo.phone = agPhone;
   my_so.data.regInfo.email = agEmail;
   my_so.data.regInfo.hkid = agHKID;
   my_so.data.regInfo.address = agAddress;
   my_so.flush();
   var _loc7_;
   if(mdm.Network.checkConnection())
   {
      var result_lv = new LoadVars();
      _loc7_ = new LoadVars();
      _loc7_.k1 = my_so.data.regInfo.k1;
      _loc7_.k2 = my_so.data.regInfo.k2;
      _loc7_.k3 = createKey(regInfo.getKeyACS()[0],regInfo.getKeyACS()[1],my_so.data.regInfo.k1,my_so.data.regInfo.k2,my_so.data.regInfo.d1);
      _loc7_.d1 = my_so.data.regInfo.d1;
      _loc7_.username = agUsername;
      _loc7_.phone = agPhone;
      _loc7_.email = agEmail;
      _loc7_.hkid = agHKID;
      _loc7_.address = agAddress;
      if(my_so.data.regInfo.k2 == mdm.System.getHDSerial(regInfo.getHD()).toUpperCase())
      {
         _loc7_.sendAndLoad(regInfo.getKeyAPath(),result_lv,"POST");
         result_lv.onLoad = function(success)
         {
            if(success)
            {
               my_so.data.regInfo.numNotConnect = 0;
               my_so.flush();
               if(result_lv.valid == "true" || result_lv.valid == true)
               {
                  licMode = "activated";
                  my_so.data.regInfo.k3 = createKey(regInfo.getKeyACS()[0],regInfo.getKeyACS()[1],my_so.data.regInfo.k1,my_so.data.regInfo.k2,my_so.data.regInfo.d1);
                  my_so.flush();
                  reg.gotoAndStop(regInfo.getMode(licMode));
                  return true;
               }
               if(result_lv.valid == "false" || result_lv.valid == false)
               {
                  licMode = "noKeyS";
                  reg.popup.gotoAndStop("badSerial");
               }
               else if(result_lv.valid == "false1")
               {
                  licMode = "noKeyA";
                  reg.popup.gotoAndStop("activatedAccount");
               }
               else
               {
                  licMode = "noKeyA";
                  reg.popup.gotoAndStop("sysError");
               }
               my_so.data.regInfo.k1 = "";
               my_so.data.regInfo.k3 = "";
               my_so.flush();
               reg.popup.nextPage = regInfo.getMode(licMode);
               reg.popup._visible = true;
               return false;
            }
            licMode = "noKeyA";
            reg.popup.nextPage = regInfo.getMode(licMode);
            reg.popup._visible = true;
            reg.popup.gotoAndStop("sysError");
            return false;
         };
      }
      else
      {
         licMode = "noKeyA";
         my_so.flush();
         reg.popup.nextPage = regInfo.getMode(licMode);
         reg.popup._visible = true;
         reg.popup.gotoAndStop("badActivate");
      }
   }
   reg.popup.nextPage = "noka";
   reg.popup._visible = true;
   reg.popup.gotoAndStop("noISP");
   return false;
}
function storeKeyA(agKeyA)
{
   var _loc2_ = SharedObject.getLocal("prince2set","/");
   var _loc3_ = mdm.Encryption.decryptString(regInfo.getKeyACS()[0],agKeyA);
   var _loc4_ = _loc3_.split(regInfo.getKeyACS()[1]);
   var _loc5_;
   var _loc6_;
   var _loc7_;
   var _loc8_;
   var _loc9_;
   var _loc10_;
   var _loc11_;
   var _loc12_;
   if(_loc4_[0] == "" && _loc4_[1] == _loc2_.data.regInfo.k2 && _loc4_[2] == _loc2_.data.regInfo.k1)
   {
      _loc2_.data.regInfo.k3 = agKeyA;
      _loc5_ = new Date();
      _loc6_ = _loc5_.getFullYear();
      _loc7_ = _loc5_.getMonth() >= 10 ? _loc5_.getMonth() : "0" + _loc5_.getMonth();
      _loc8_ = _loc5_.getDate() >= 10 ? _loc5_.getDate() : "0" + _loc5_.getDate();
      _loc9_ = _loc5_.getHours() >= 10 ? _loc5_.getHours() : "0" + _loc5_.getHours();
      _loc10_ = _loc5_.getMinutes() >= 10 ? _loc5_.getMinutes() : "0" + _loc5_.getMinutes();
      _loc11_ = _loc5_.getSeconds() >= 10 ? _loc5_.getSeconds() : "0" + _loc5_.getSeconds();
      _loc12_ = _loc5_.getMilliseconds() >= 10 ? (_loc5_.getMilliseconds() >= 100 ? _loc5_.getMilliseconds() : "0" + _loc5_.getMilliseconds()) : "00" + _loc5_.getMilliseconds();
      _loc2_.data.regInfo.d1 = _loc6_ + "" + _loc7_ + "" + _loc8_ + "" + _loc9_ + "" + _loc10_ + "" + _loc11_ + "" + _loc12_;
      _loc2_.flush();
      return true;
   }
   return false;
}
function getEncryptKey()
{
   var _loc1_ = SharedObject.getLocal("prince2set","/");
   return mdm.Encryption.encryptString(regInfo.getKeyACS()[0],_loc1_.data.regInfo.k1 + regInfo.getKeyACS()[1] + mdm.Encryption.encryptString(regInfo.getKeyACS()[0],_loc1_.data.regInfo.k2));
}
function checkManual(agKeyA)
{
   if(agKeyA != "")
   {
      if(storeKeyA(agKeyA))
      {
         licMode = "activated";
         reg.gotoAndStop(regInfo.getMode(licMode));
      }
      else
      {
         licMode = "noKeyA";
         reg.popup.nextPage = regInfo.getMode(licMode);
         reg.popup._visible = true;
         reg.popup.gotoAndStop("badActivate");
      }
   }
   else
   {
      licMode = "noKeyA";
      reg.popup.nextPage = regInfo.getMode(licMode);
      reg.popup._visible = true;
      reg.popup.gotoAndStop("badActivate");
   }
}
function createKey(agCode, agCode2, agK1, agK2, agD1)
{
   return mdm.Encryption.encryptString(agCode,agCode2 + agK2 + agCode2 + agK1);
}
