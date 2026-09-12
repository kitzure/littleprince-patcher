Array.prototype.randomize = function()
{
   var _loc2_ = this;
   var _loc3_ = _loc2_.length;
   if(_loc3_ == 0)
   {
      return undefined;
   }
   var _loc4_;
   var _loc6_;
   var _loc5_;
   while(_loc3_ = _loc3_ - 1)
   {
      _loc4_ = Math.floor(Math.random() * (_loc3_ + 1));
      _loc6_ = _loc2_[_loc3_];
      _loc5_ = _loc2_[_loc4_];
      _loc2_[_loc3_] = _loc5_;
      _loc2_[_loc4_] = _loc6_;
   }
   return _loc2_;
};
Array.prototype.createIndexArray = function()
{
   var _loc6_ = arguments[0];
   var _loc7_ = arguments[1];
   var _loc5_ = this;
   if(_loc6_ <= 0)
   {
      return null;
   }
   var _loc4_ = 1;
   if(_loc7_ == undefined)
   {
      _loc4_ = 1;
   }
   else
   {
      if(isNaN(_loc7_))
      {
         return null;
      }
      _loc4_ = _loc7_;
   }
   _loc5_ = new Array();
   var _loc3_ = _loc4_;
   while(_loc3_ < _loc6_ + _loc4_)
   {
      _loc5_.push(_loc3_);
      _loc3_ = _loc3_ + 1;
   }
   return _loc5_;
};
