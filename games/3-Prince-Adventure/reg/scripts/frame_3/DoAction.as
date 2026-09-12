btnQuit.onRelease = function()
{
   _root.applicationClose();
};
setBtn(btn_activate);
setBtn(btn_try);
btn_activate.onRelease = function()
{
   Prince3.PrinceSystem.loadOpening();
};
btn_try.onRelease = function()
{
   this._parent._parent.trial();
};
txtUsername.restrict = "A-Z a-z";
txtPhone.restrict = "0-9 \\-";
txtSerial.restrict = "A-Z0-9\\-";
if(Username)
{
   txtUsername.text = Username;
}
if(Phone)
{
   txtPhone.text = Phone;
}
if(Email)
{
   txtEmail.text = Email;
}
if(Serial)
{
   txtSerial.text = Serial;
}
txtUsername.tabIndex = 1;
txtPhone.tabIndex = 2;
txtEmail.tabIndex = 3;
txtSerial.tabIndex = 4;
stop();
