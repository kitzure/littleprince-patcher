function initSys(agVersion)
{
   ver = agVersion;
   verShort = ver.substring(0,2);
   fscommand("showMenu",false);
   fscommand("allowScale",false);
   frameRate = 24;
   MovieClip.prototype.useHandCursor = false;
   Button.prototype.useHandCursor = false;
   if(ver == "cddemo" || ver == "cdsingle")
   {
      localPath = mdm.Application.pathUnicode;
   }
   var _loc1_;
   if(ver == "cddemo" || ver == "cdsingle" || ver == "cdwebsunny")
   {
      _loc1_ = SharedObject.getLocal("prince2set","/");
   }
   if(ver == "webdemo" || ver == "webedcity" || ver == "webdemoedcity" || ver == "websunny" || ver == "webschool" || ver == "testing")
   {
      appPath = "";
   }
   else if(ver == "cddemo" || ver == "cdsingle")
   {
      appPath = localPath;
   }
   else if(ver == "cdwebsunny")
   {
      appPath = "http://file.sunnyinteractive.com/download/hung/test/";
   }
   verLevel = 100000;
   loadingColor = "green";
   channel1 = "none";
   channel2 = "none";
}
