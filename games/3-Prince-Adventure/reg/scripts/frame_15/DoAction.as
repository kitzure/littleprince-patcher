setBtn(btn_start);
setBtn(btn_print);
btn_print.onRelease = function()
{
   printAsBitmap(_root,"bmovie");
};
btn_start.onRelease = function()
{
   Prince3.PrinceSystem.loadOpening();
};
txtUsername.text = Username;
txtPhone.text = Phone;
txtEmail.text = Email;
txtSerial.text = Serial;
