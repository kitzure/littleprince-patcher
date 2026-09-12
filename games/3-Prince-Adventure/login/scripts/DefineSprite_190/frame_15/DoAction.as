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
   this._parent._parent.loginPageInit();
   this._parent.play();
};
stop();
