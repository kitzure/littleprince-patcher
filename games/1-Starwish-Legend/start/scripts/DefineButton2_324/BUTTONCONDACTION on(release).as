on(release){
   _parent._parent._parent.user.extra ^= 8;
   if(_parent._parent._parent.user.extra & 8)
   {
      gotoAndStop(2);
   }
   else
   {
      gotoAndStop(1);
   }
}
