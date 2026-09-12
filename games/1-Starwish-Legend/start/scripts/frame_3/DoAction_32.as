function loadTrialVersion()
{
   reg.unloadMovie();
   initSystem("cdsingle");
}
function loadFullVersion()
{
   reg.unloadMovie();
   initSystem("cdsingle");
}
if(_root != _level0)
{
   validateLogin("admin","prince");
   loadSystem();
   callGame(_level0.gameid);
}
stop();
