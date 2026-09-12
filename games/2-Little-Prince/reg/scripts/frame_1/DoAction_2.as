function setBtn(pmBtn)
{
   pmBtn.stop();
   pmBtn.onRollOver = function()
   {
      this.gotoAndStop(2);
   };
   pmBtn.onRollOut = pmBtn.onReleaseOutside = function()
   {
      this.gotoAndStop(1);
   };
   pmBtn.onPress = function()
   {
      this.gotoAndStop(3);
   };
}
function popup(pmErr, pmRestore)
{
   mc_popup.gotoAndPlay(pmErr);
   onEnterFrame = function()
   {
      mc_popup.btn_clear.useHandCursor = false;
      delete onEnterFrame;
   };
   restore = pmRestore;
   var _loc1_ = 1;
   while(_loc1_ <= restore.length)
   {
      restore[_loc1_ - 1].gotoAndStop(1);
      restore[_loc1_ - 1].mc_over.gotoAndStop(1);
      _loc1_ = _loc1_ + 1;
   }
   mc_prince.mc_head.gotoAndStop(5);
}
function killPopup()
{
   mc_popup.gotoAndStop(1);
   var _loc1_ = 1;
   while(_loc1_ <= restore.length)
   {
      restore[_loc1_ - 1].mc_over.play();
      _loc1_ = _loc1_ + 1;
   }
   mc_prince.mc_head.gotoAndPlay(1);
}
function correctEmailFormat(em)
{
   var _loc3_ = em.lastIndexOf(".");
   var _loc2_ = em.lastIndexOf("@");
   if(_loc3_ > 0 && _loc2_ > 0 && _loc3_ < em.length - 1 && _loc3_ - _loc2_ > 1 && em.lastIndexOf("@",_loc2_ - 1) < 0 && em.split(" ").length == 1 && em.substr(_loc2_ + 1,1) != ".")
   {
      return true;
   }
   return false;
}
function correctSNFormat()
{
   var _loc2_ = Serial.split("-");
   if(_loc2_.length != 5)
   {
      return false;
   }
   if(_loc2_[0] != "P1")
   {
      return false;
   }
   var _loc1_ = 1;
   while(_loc1_ < 5)
   {
      if(_loc2_[_loc1_].length != 4)
      {
         return false;
      }
      _loc1_ = _loc1_ + 1;
   }
   return true;
}
function checkInput()
{
   var _loc2_ = false;
   Username = txtUsername.text;
   Phone = txtPhone.text;
   Email = txtEmail.text;
   Serial = txtSerial.text;
   if(Username.length < 1)
   {
      _loc2_ = true;
      mc_al_name.gotoAndPlay("a1");
   }
   else
   {
      mc_al_name.gotoAndStop(1);
   }
   if(Phone.length < 1)
   {
      _loc2_ = true;
      mc_al_phone.gotoAndPlay("a1");
   }
   else
   {
      mc_al_phone.gotoAndStop(1);
   }
   if(Email.length < 1)
   {
      _loc2_ = true;
      mc_al_email.gotoAndPlay("a1");
   }
   else if(correctEmailFormat(Email))
   {
      mc_al_email.gotoAndStop(1);
   }
   else
   {
      _loc2_ = true;
      mc_al_email.gotoAndPlay("a2");
   }
   if(Serial.length < 1)
   {
      _loc2_ = true;
      mc_al_serial.gotoAndPlay("a1");
   }
   else if(correctSNFormat())
   {
      mc_al_serial.gotoAndStop(1);
   }
   else
   {
      _loc2_ = true;
      mc_al_serial.gotoAndPlay("a2");
   }
   if(!_loc2_)
   {
      _parent.connectActivationServer();
   }
}
