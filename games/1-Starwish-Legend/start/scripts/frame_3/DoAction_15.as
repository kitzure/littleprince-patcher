function loadOpening()
{
   loadFullVersion();
}
function createAdmin()
{
   trace("createAdmin");
   return true;
}
function initUser(agUsername)
{
   user = loadUserData(agUsername);
}
function oldRequestKey(sn, hdkey)
{
   return mdm.Encryption.encryptString("SIEdutainment",sn + "|=_=|" + mdm.Encryption.encryptString("SIEdutainment",hdkey));
}
function alert(msg)
{
   mdm.Dialogs.prompt(msg);
}
function applicationClose()
{
   mdm.Application.exit();
}
function getHDKey()
{
   return mdm.System.getHDSerial("c");
}
function haveNetwork()
{
   return mdm.Network.checkConnection();
}
function loadRegSWF()
{
   reg.unloadMovie();
   mcl.loadClip("reg.swf",reg);
}
function onLoadStart(target_mc)
{
   trace("load start: " + target_mc);
}
function onLoadProgress(target_mc, bytesLoaded, bytesTotal)
{
}
function onLoadInit(target_mc)
{
   Reg.onLoadInit(target_mc);
}
initGameSpec();
initGemSpec();
initItemSpec();
SaveLoadSystem.init(this,mdm);
Reg.init({url:"reg.swf",target:reg});
var adminName = "admin";
var adminPass = "prince";
var demoName = "demo";
var demoPass = "demo";
validateLogin = SaveLoadSystem.validateLogin;
hasDuplicateUser = SaveLoadSystem.hasDuplicateUser;
createUser = SaveLoadSystem.createUser;
loadUserData = SaveLoadSystem.loadUserData;
saveUserData = SaveLoadSystem.saveUserData;
numUsers = SaveLoadSystem.numUsers;
getAccountList = SaveLoadSystem.getNonAdminAccounts;
getRanks = SaveLoadSystem.getRanks;
delAccount = SaveLoadSystem.delAccount;
requestKey = Reg.requestKey;
checkActivation = Reg.checkActivation;
connectActivationServer = Reg.connectActivationServer;
reactivation = Reg.reactivation;
activationResponse = Reg.activationResponse;
var mcl = new MovieClipLoader();
mcl.addListener(this);
