on(release){
   if(_parent._parent._parent.user.firstHint == true)
   {
      _parent._parent._parent.user.firstHint = false;
      gotoAndStop(2);
   }
   else
   {
      _parent._parent._parent.user.firstHint = true;
      gotoAndStop(1);
   }
}
