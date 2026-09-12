_parent.setBtn(btn_retry);
_parent.setBtn(btn_code);
btn_retry.onRelease = function()
{
   _parent.killPopup();
};
btn_code.onRelease = function()
{
   _parent.killPopup();
   _parent.gotoAndStop("code");
};
