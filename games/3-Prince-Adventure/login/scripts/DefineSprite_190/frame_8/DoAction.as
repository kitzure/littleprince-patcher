btn_ok.onRollOut = btn_ok.onReleaseOutside = function()
{
   this.gotoAndStop("normal");
};
btn_ok.onRollOver = function()
{
   this.gotoAndStop("over");
};
btn_ok.onPress = function()
{
   this.gotoAndStop("down");
};
btn_ok.onRelease = function()
{
   Prince3.PrinceSystem.delUser(this._parent._parent.sel);
   this._parent.play();
};
btn_cancel.onRollOut = btn_cancel.onReleaseOutside = function()
{
   this.gotoAndStop("normal");
};
btn_cancel.onRollOver = function()
{
   this.gotoAndStop("over");
};
btn_cancel.onPress = function()
{
   this.gotoAndStop("down");
};
btn_cancel.onRelease = function()
{
   this._parent.gotoAndStop(1);
};
stop();
