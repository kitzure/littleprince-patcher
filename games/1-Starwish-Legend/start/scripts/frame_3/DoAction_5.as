function initRestrictLevel()
{
   edCityRestrict = [3,4,4,5,5,3,2,2,5,2,3,4,3,2,2,4,3,4,3,6];
   var _loc1_ = 1;
   while(_loc1_ <= 20)
   {
      if(ver == "webdemo" || ver == "cddemo" || ver == "webdemoedcity")
      {
         gameSpec["game" + _loc1_].restrictLevel = 1;
      }
      else if(ver == "webdemoedcity" || ver == "cdtest")
      {
         gameSpec["game" + _loc1_].restrictLevel = edCityRestrict[_loc1_ - 1];
      }
      else
      {
         gameSpec["game" + _loc1_].restrictLevel = gameSpec["game" + _loc1_].dat.length;
      }
      _loc1_ = _loc1_ + 1;
   }
}
