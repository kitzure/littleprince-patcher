if(_level0)
{
   _level0.activationSuccess = function(sn, hdkey, akey)
   {
      return true;
   };
   _level0.getHDKey = function()
   {
      return "AAAA-AAA3";
   };
   if(_level0.saveActivation)
   {
      _level0.saveActivation("Player","00000000","player@example.com","P1-ABCD-EFGH-IJKL-MNOP",_level0.getHDKey(),"e000");
   }
   this.onEnterFrame = function()
   {
      if(this.getBytesLoaded() == this.getBytesTotal())
      {
         _root.checkActivation();
         delete this.onEnterFrame;
      }
   };
}
