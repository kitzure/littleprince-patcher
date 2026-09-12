function initHiddenGemSpec()
{
   var _loc7_;
   var _loc6_;
   var _loc2_;
   var _loc5_;
   var _loc1_;
   if(ver == "cdsingle")
   {
      _loc7_ = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];
      _loc6_ = _loc7_.randomize();
      chosenGame = _loc6_.splice(0,5);
      _loc2_ = 1;
      while(_loc2_ <= 5)
      {
         _loc5_ = gameSpec["game" + chosenGame[_loc2_ - 1]].dat.length;
         _loc1_ = 0;
         while(_loc1_ <= 1)
         {
            gameSpec["game" + chosenGame[_loc2_ - 1]].dat[_loc5_ - _loc1_ - 1].getGem.push({gemType:_loc2_ + 5,no:2 - _loc1_});
            _loc1_ = _loc1_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
