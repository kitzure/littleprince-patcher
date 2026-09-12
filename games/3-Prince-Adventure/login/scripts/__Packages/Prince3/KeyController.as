class Prince3.KeyController
{
   var keyConfig;
   var oldKey;
   var target;
   function KeyController(t, kcfg)
   {
      this.target = t;
      this.keyConfig = kcfg;
      this.oldKey = 0;
   }
   function reset()
   {
      this.oldKey = 0;
   }
   function run()
   {
      var _loc3_ = this.oldKey;
      this.oldKey = 0;
      var _loc2_ = this.keyConfig.length - 1;
      while(_loc2_ >= 0)
      {
         if(Key.isDown(this.keyConfig[_loc2_].keyCode))
         {
            this.oldKey |= 1 << _loc2_;
         }
         _loc2_ = _loc2_ - 1;
      }
      if(this.oldKey)
      {
         this.target.onKeyPress(this.oldKey);
      }
      else
      {
         this.target.onKeyUnpress();
      }
      var _loc4_ = _loc3_;
      _loc2_ = 0;
      while(_loc2_ < this.keyConfig.length)
      {
         if(_loc4_ & 1)
         {
            this.target[this.keyConfig[_loc2_].pressEvent]();
         }
         _loc4_ >>= 1;
         _loc2_ = _loc2_ + 1;
      }
      _loc3_ = this.oldKey & (_loc3_ ^ this.oldKey);
      _loc2_ = 0;
      while(_loc2_ < this.keyConfig.length)
      {
         if(_loc3_ & 1)
         {
            this.target[this.keyConfig[_loc2_].triggerEvent]();
         }
         _loc3_ >>= 1;
         _loc2_ = _loc2_ + 1;
      }
   }
}
