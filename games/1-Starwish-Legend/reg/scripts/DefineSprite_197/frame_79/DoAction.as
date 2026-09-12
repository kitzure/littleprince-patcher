_parent.setBtn(btn_ok);
_parent.setBtn(btn_cancel);
btn_ok.onRelease = function()
{
   var _loc2_ = false;
   if(this._parent.txtPhone.text.length < 1)
   {
      _loc2_ = true;
      this._parent.mc_al_phone.gotoAndPlay("a1");
   }
   else
   {
      this._parent.mc_al_phone.gotoAndStop(1);
   }
   if(this._parent.txtEmail.text.length < 1)
   {
      _loc2_ = true;
      this._parent.mc_al_email.gotoAndPlay("a1");
   }
   else if(!this._parent._parent.correctEmailFormat(this._parent.txtEmail.text))
   {
      _loc2_ = true;
      this._parent.mc_al_email.gotoAndStop("a2");
   }
   else
   {
      this._parent.mc_al_email.gotoAndStop(1);
   }
   if(!_loc2_)
   {
      this._parent._parent.Phone = this._parent.txtPhone.text;
      this._parent._parent.Email = this._parent.txtEmail.text;
      this._parent._parent._parent.reactivation();
      this._parent.last = 83;
      this._parent.gotoAndPlay("e070l");
   }
};
btn_cancel.onRelease = function()
{
   _root.clearActivation();
   this._parent._parent.Username = "";
   this._parent._parent.Phone = "";
   this._parent._parent.Email = "";
   this._parent._parent.Serial = "";
   this._parent._parent.gotoAndStop("form");
   this._parent._parent.txtUsername.tabIndex = 1;
   this._parent._parent.txtPhone.tabIndex = 2;
   this._parent._parent.txtEmail.tabIndex = 3;
   this._parent._parent.txtSerial.tabIndex = 4;
   this._parent._parent.killPopup();
};
if(_parent.Phone)
{
   txtPhone.text = _parent.Phone;
}
if(_parent.Email)
{
   txtEmail.text = _parent.Email;
}
txtSerial.text = _parent.Serial;
txtPhone.restrict = "0-9 \\-";
this._parent.txtUsername.tabIndex = undefined;
this._parent.txtPhone.tabIndex = undefined;
this._parent.txtEmail.tabIndex = undefined;
this._parent.txtSerial.tabIndex = undefined;
this.txtPhone.tabIndex = 1;
this.txtEmail.tabIndex = 2;
