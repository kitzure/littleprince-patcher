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
var verNumber = "2.1";
var lvar = new LoadVars();
lvar.onData = function(src)
{
   _root.verNumber = src;
};
lvar.load("version.txt");
regInfo = new RegInfo();
checkRegInfo();
if(_root != _level0)
{
   validateLogin("admin","prince");
   loadSystem();
   callGame(_level0.gameid);
}
stop();
