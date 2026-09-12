function createAdmin()
{
   return createUser(adminName,adminPass,"Admin",1,"管理員",1,6,"A",2,true);
}
function validateLogin(agUsername, agUserPass)
{
   trace("validateLogin(" + agUsername + ", " + agUserPass + ")");
   var _loc2_ = SharedObject.getLocal("prince2set","/");
   var _loc5_ = false;
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.data.userList.length)
   {
      trace("check pass: " + _loc2_.data.userList[_loc1_].username + "," + agUsername + "," + _loc2_.data.userList[_loc1_].password + "," + agUserPass);
      if(_loc2_.data.userList[_loc1_].username == agUsername && _loc2_.data.userList[_loc1_].password == agUserPass)
      {
         _loc5_ = true;
         initUser(agUsername);
         break;
      }
      _loc1_ = _loc1_ + 1;
   }
   if(!_loc5_ && agUsername == adminName && agUserPass == adminPass)
   {
      if(createAdmin())
      {
         _loc5_ = true;
         initUser(adminName);
      }
   }
   return _loc5_;
}
function hasDuplicateUser(agUsername)
{
   var _loc2_ = SharedObject.getLocal("prince2set","/");
   var _loc3_ = false;
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.data.userList.length)
   {
      if(_loc2_.data.userList[_loc1_].username == agUsername)
      {
         _loc3_ = true;
         break;
      }
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
}
function createUser(agUsername, agUserPass, agName, agGender, agSchool, agEdLevel, agClassLevel, agClassName, agType)
{
   trace("createUser(" + agUsername + "," + agUserPass + "," + agName + "," + agGender + "," + agSchool + "," + agEdLevel + "," + agClassLevel + "," + agClassName + "," + agType + ")");
   var _loc7_ = SharedObject.getLocal("prince2set","/");
   var _loc5_ = false;
   _loc5_ = hasDuplicateUser(agUsername);
   if(_loc5_)
   {
      return false;
   }
   var _loc3_ = new Object();
   _loc3_.scoreReport = null;
   _loc3_.itemReport = null;
   if(agUsername == adminName)
   {
      _loc3_.gemReport = [10,10,10,10,10,5,5,5,5,5];
      _loc3_.itemReport = [["1-0",200]];
      _loc3_.score = 10000;
   }
   else
   {
      _loc3_.scoreReport = null;
      _loc3_.gemReport = null;
      _loc3_.itemReport = null;
      _loc3_.score = 0;
   }
   agUser.equipment = new Array();
   _loc3_.username = agUsername;
   _loc3_.password = agUserPass;
   if(agType)
   {
      _loc3_.type = agType;
   }
   else
   {
      _loc3_.type = 1;
   }
   _loc3_.name = agName;
   _loc3_.gender = agGender;
   _loc3_.school = agSchool;
   _loc3_.edLevel = agEdLevel;
   _loc3_.classLevel = agClassLevel;
   _loc3_.className = agClassName;
   _loc3_.firstHint = true;
   _loc3_.quality = 0;
   _loc3_.winmode = 1;
   _loc3_.musicvolume = 0;
   _loc3_.bossQue = new Array();
   var _loc4_ = 0;
   var _loc2_;
   while(_loc4_ < 4)
   {
      _loc3_.bossQue.push(new Array());
      _loc2_ = 0;
      while(_loc2_ < 4)
      {
         this.bossQue[_loc4_].push(0);
         _loc2_ = _loc2_ + 1;
      }
      _loc4_ = _loc4_ + 1;
   }
   _loc3_.defeatedBoss = new Array();
   _loc4_ = 0;
   while(_loc4_ < 4)
   {
      _loc3_.defeatedBoss.push(0);
      _loc4_ = _loc4_ + 1;
   }
   _loc7_.data.userList.push(_loc3_);
   _loc7_.flush();
   return true;
}
function loadUserData(agUsername)
{
   trace("loadUserData(" + agUsername + ")");
   var _loc2_ = SharedObject.getLocal("prince2set","/");
   var _loc3_ = new User();
   var _loc1_ = 0;
   var _loc4_;
   var _loc6_;
   var _loc5_;
   while(_loc1_ < _loc2_.data.userList.length)
   {
      if(_loc2_.data.userList[_loc1_].username == agUsername)
      {
         _loc4_ = _loc2_.data.userList[_loc1_].scoreReport;
         _loc6_ = _loc2_.data.userList[_loc1_].gemReport;
         _loc5_ = _loc2_.data.userList[_loc1_].itemReport;
         _loc3_.report = new Report(_loc4_,gameSpec,_loc6_,gemSpec,_loc5_,itemSpec);
         _loc3_.equipment = _loc2_.data.userList[_loc1_].equipment.slice(0);
         _loc3_.score = _loc2_.data.userList[_loc1_].score;
         _loc3_.username = _loc2_.data.userList[_loc1_].username;
         _loc3_.password = _loc2_.data.userList[_loc1_].password;
         _loc3_.type = _loc2_.data.userList[_loc1_].type;
         _loc3_.name = _loc2_.data.userList[_loc1_].name;
         _loc3_.gender = _loc2_.data.userList[_loc1_].gender;
         _loc3_.school = _loc2_.data.userList[_loc1_].school;
         _loc3_.edLevel = _loc2_.data.userList[_loc1_].edLevel;
         _loc3_.classLevel = _loc2_.data.userList[_loc1_].classLevel;
         if(_loc2_.data.userList[_loc1_].edLevel >= 2 || _loc2_.data.userList[_loc1_].classLevel > 4)
         {
            _loc3_.passRate = 0.8;
         }
         else if(_loc2_.data.userList[_loc1_].classLevel > 2)
         {
            _loc3_.passRate = 0.7;
         }
         else
         {
            _loc3_.passRate = 0.6;
         }
         _loc3_.className = _loc2_.data.userList[_loc1_].className;
         _loc3_.bossQue = _loc2_.data.userList[_loc1_].bossQue.slice(O);
         _loc3_.defeatedBoss = _loc2_.data.userList[_loc1_].defeatedBoss.slice(O);
         _loc3_.firstHint = _loc2_.data.userList[_loc1_].firstHint;
         _loc3_.quality = _loc2_.data.userList[_loc1_].quality;
         _loc3_.winmode = _loc2_.data.userList[_loc1_].winmode;
         _loc3_.musicvolume = _loc2_.data.userList[_loc1_].musicvolume;
         _loc3_.language = _loc2_.data.userList[_loc1_].language != undefined ? _loc2_.data.userList[_loc1_].language : 1;
         _loc3_.extra = _loc2_.data.userList[_loc1_].extra ? _loc2_.data.userList[_loc1_].extra : 0;
         if(_loc3_.defeatedBoss.length == 4)
         {
            _loc3_.defeatedBoss.push(0);
         }
         break;
      }
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
}
function saveUserData(agUser)
{
   var _loc3_;
   var _loc2_;
   var _loc5_;
   var _loc1_;
   try
   {
      _loc3_ = SharedObject.getLocal("prince2set","/");
      _loc2_ = new Object();
      _loc2_.scoreReport = agUser.report.getScoreBoardInArray();
      _loc2_.gemReport = agUser.report.getGemBoard();
      _loc2_.itemReport = agUser.report.getItemBoardInArray();
      _loc2_.score = agUser.score;
      _loc2_.equipment = agUser.equipment.slice(0);
      _loc2_.username = agUser.username;
      _loc2_.password = agUser.password;
      _loc2_.type = agUser.type;
      _loc2_.name = agUser.name;
      _loc2_.gender = agUser.gender;
      _loc2_.school = agUser.school;
      _loc2_.edLevel = agUser.edLevel;
      _loc2_.classLevel = agUser.classLevel;
      _loc2_.className = agUser.className;
      _loc2_.bossQue = agUser.bossQue.slice(0);
      _loc2_.defeatedBoss = agUser.defeatedBoss.slice(0);
      _loc2_.firstHint = agUser.firstHint;
      _loc2_.quality = agUser.quality;
      _loc2_.winmode = agUser.winmode;
      _loc2_.musicvolume = agUser.musicvolume;
      _loc2_.language = agUser.language;
      _loc2_.extra = agUser.extra;
      _loc5_ = false;
      _loc1_ = 0;
      while(_loc1_ < _loc3_.data.userList.length)
      {
         if(_loc3_.data.userList[_loc1_].username == agUser.username)
         {
            _loc3_.data.userList[_loc1_].scoreReport = _loc2_.scoreReport.slice(0);
            _loc3_.data.userList[_loc1_].gemReport = _loc2_.gemReport.slice(0);
            _loc3_.data.userList[_loc1_].itemReport = _loc2_.itemReport.slice(0);
            _loc3_.data.userList[_loc1_].score = _loc2_.score;
            _loc3_.data.userList[_loc1_].equipment = _loc2_.equipment.slice(0);
            _loc3_.data.userList[_loc1_].username = _loc2_.username;
            _loc3_.data.userList[_loc1_].password = _loc2_.password;
            _loc3_.data.userList[_loc1_].type = _loc2_.type;
            _loc3_.data.userList[_loc1_].name = _loc2_.name;
            _loc3_.data.userList[_loc1_].gender = _loc2_.gender;
            _loc3_.data.userList[_loc1_].school = _loc2_.school;
            _loc3_.data.userList[_loc1_].edLevel = _loc2_.edLevel;
            _loc3_.data.userList[_loc1_].classLevel = _loc2_.classLevel;
            _loc3_.data.userList[_loc1_].className = _loc2_.className;
            _loc3_.data.userList[_loc1_].bossQue = _loc2_.bossQue.slice(0);
            _loc3_.data.userList[_loc1_].defeatedBoss = _loc2_.defeatedBoss.slice(0);
            _loc3_.data.userList[_loc1_].firstHint = _loc2_.firstHint;
            _loc3_.data.userList[_loc1_].quality = _loc2_.quality;
            _loc3_.data.userList[_loc1_].winmode = _loc2_.winmode;
            _loc3_.data.userList[_loc1_].musicvolume = _loc2_.musicvolume;
            _loc3_.data.userList[_loc1_].language = _loc2_.language;
            _loc3_.data.userList[_loc1_].extra = _loc2_.extra;
            _loc5_ = true;
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(!_loc5_)
      {
         _loc3_.data.userList.push(_loc2_);
      }
      _loc3_.flush();
   }
   catch(e_err:Error)
   {
      trace(e_err.toString());
   }
}
function numUsers()
{
   var _loc1_ = SharedObject.getLocal("prince2set","/");
   return _loc1_.data.userList.length;
}
var adminName = "admin";
var adminPass = "prince";
var demoName = "demo";
var demoPass = "demo";
