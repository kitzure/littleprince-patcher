class RegInfo
{
   function RegInfo()
   {
   }
   function getHD()
   {
      return "c";
   }
   function getKeyACS()
   {
      var _loc1_ = ["SIEdutainment","|=_=|"];
      return _loc1_;
   }
   function getKeyAPath()
   {
      return "http://www.sunnyinteractive.com/littleprince/reg/validate.php";
   }
   function getMode(agMode)
   {
      var _loc1_ = "";
      switch(agMode)
      {
         case "noKeyS":
            _loc1_ = "noks";
            break;
         case "noKeyA":
            _loc1_ = "noka";
            break;
         case "fullcd":
            _loc1_ = "fcd";
            break;
         case "activated":
            _loc1_ = "activated";
      }
      return _loc1_;
   }
}
