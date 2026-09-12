setBtn(btn_start);
setBtn(btn_print);
btn_print.onRelease = function()
{
   this.txtUsername.text = this._parent.Username;
   this.txtPhone.text = this._parent.Phone;
   this.txtEmail.text = this._parent.Email;
   this.txtSerial.text = this._parent.Serial;
   printAsBitmap(this._parent.mc_print,"bmax");
};
btn_start.onRelease = function()
{
   _root.loadOpening();
};
txtUsername.text = Username;
txtPhone.text = Phone;
txtEmail.text = Email;
txtSerial.text = Serial;
mc_print.txtUsername.text = Username;
mc_print.txtPhone.text = Phone;
mc_print.txtEmail.text = Email;
mc_print.txtSerial.text = Serial;
