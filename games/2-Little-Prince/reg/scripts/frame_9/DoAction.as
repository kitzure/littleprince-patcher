setBtn(btn_print);
setBtn(btn_back);
setBtn(btn_activate);
btn_activate.onRelease = function()
{
   if(this._parent.akey.text.length < 1)
   {
      this._parent.alert_act.gotoAndPlay("a1");
   }
   else
   {
      this._parent._parent.activationResponse(this._parent.akey.text);
   }
};
btn_back.onRelease = function()
{
   this.gotoAndStop(2);
   gotoAndStop("form");
};
btn_print.onRelease = function()
{
   printAsBitmap(this._parent.mc_print,"bmax");
};
var str = _root.requestKey(Serial,_root.getHDKey()).substr(0,32);
var str2 = "";
var i = 0;
while(i < str.length)
{
   if(i)
   {
      str2 += "-";
   }
   str2 += str.substr(i,4);
   i += 4;
}
key.text = str2;
mc_print.key.text = key.text;
akey.text = "";
akey.restrict = "0-9";
