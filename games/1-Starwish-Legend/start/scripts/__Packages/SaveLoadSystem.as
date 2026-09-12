class SaveLoadSystem
{
   static var _filename;
   static var _userList;
   static var mdm;
   static var root;
   static var savePath;
   static var adminName = "admin";
   static var adminPass = "prince";
   static var demoName = "demo";
   static var demoPass = "demo";
   static var notSaveNow = false;
   function SaveLoadSystem()
   {
   }
   static function getRanks()
   {
      var _loc2_ = new Object();
      _loc2_.score_rank = new Array();
      _loc2_.star_rank = new Array();
      _loc2_.equip_rank = new Array();
      var _loc4_;
      var _loc1_;
      var _loc5_;
      var _loc3_;
      if(SaveLoadSystem.root.user.username != SaveLoadSystem.demoName)
      {
         _loc4_ = 0;
         while(_loc4_ < SaveLoadSystem._userList.length)
         {
            if(SaveLoadSystem._userList[_loc4_].type != 2)
            {
               _loc1_ = new Object();
               _loc1_.name = SaveLoadSystem._userList[_loc4_].name;
               _loc1_.school = SaveLoadSystem._userList[_loc4_].school;
               _loc1_.gender = SaveLoadSystem._userList[_loc4_].gender;
               _loc1_.score = SaveLoadSystem._userList[_loc4_].score;
               _loc1_.className = SaveLoadSystem._userList[_loc4_].className;
               _loc1_.gems = SaveLoadSystem._userList[_loc4_].report.getGemBoard().concat();
               _loc1_.t_star = SaveLoadSystem._userList[_loc4_].report.getTotalGem();
               _loc5_ = SaveLoadSystem._userList[_loc4_].report.getItemBoardInArray();
               _loc1_.t_equip = 0;
               _loc3_ = 0;
               while(_loc3_ < _loc5_.length)
               {
                  _loc1_.t_equip += _loc5_[_loc3_][1];
                  _loc3_ = _loc3_ + 1;
               }
               _loc3_ = 0;
               while(_loc3_ < _loc2_.score_rank.length)
               {
                  if(_loc1_.score > _loc2_.score_rank[_loc3_].score)
                  {
                     _loc2_.score_rank.splice(_loc3_,0,_loc1_);
                     break;
                  }
                  _loc3_ = _loc3_ + 1;
               }
               if(_loc3_ == _loc2_.score_rank.length)
               {
                  _loc2_.score_rank.push(_loc1_);
               }
               _loc3_ = 0;
               while(_loc3_ < _loc2_.star_rank.length)
               {
                  if(_loc1_.t_star > _loc2_.star_rank[_loc3_].t_star)
                  {
                     _loc2_.star_rank.splice(_loc3_,0,_loc1_);
                     break;
                  }
                  _loc3_ = _loc3_ + 1;
               }
               if(_loc3_ == _loc2_.star_rank.length)
               {
                  _loc2_.star_rank.push(_loc1_);
               }
               _loc3_ = 0;
               while(_loc3_ < _loc2_.equip_rank.length)
               {
                  if(_loc1_.t_equip > _loc2_.equip_rank[_loc3_].t_equip)
                  {
                     _loc2_.equip_rank.splice(_loc3_,0,_loc1_);
                     break;
                  }
                  _loc3_ = _loc3_ + 1;
               }
               if(_loc3_ == _loc2_.equip_rank.length)
               {
                  _loc2_.equip_rank.push(_loc1_);
               }
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return _loc2_;
   }
   static function getNonAdminAccounts()
   {
      var _loc2_ = new Array();
      var _loc1_ = 0;
      while(_loc1_ < SaveLoadSystem._userList.length)
      {
         if(SaveLoadSystem._userList[_loc1_].type != 2)
         {
            _loc2_.push(SaveLoadSystem._userList[_loc1_]);
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc2_;
   }
   static function delAccount(agUsername)
   {
      var _loc1_ = 0;
      while(_loc1_ < SaveLoadSystem._userList.length)
      {
         if(SaveLoadSystem._userList[_loc1_].username == agUsername)
         {
            SaveLoadSystem._userList.splice(_loc1_,1);
            SaveLoadSystem.mdm.FileSystem.deleteFile(SaveLoadSystem._filename.splice(_loc1_,1)[0]);
            return undefined;
         }
         _loc1_ = _loc1_ + 1;
      }
   }
   static function createUser(agUsername, agUserPass, agName, agGender, agSchool, agEdLevel, agClassLevel, agClassName, agType)
   {
      trace("createUser(" + agUsername + "," + agUserPass + "," + agName + "," + agGender + "," + agSchool + "," + agEdLevel + "," + agClassLevel + "," + agClassName + "," + agType + ")");
      if(SaveLoadSystem.hasDuplicateUser(agUsername))
      {
         return false;
      }
      var _loc3_ = 0;
      var _loc1_;
      var _loc4_;
      var _loc2_;
      while(_loc3_ < 9)
      {
         if(!SaveLoadSystem.mdm.FileSystem.fileExists(SaveLoadSystem.savePath + "savedat" + _loc3_ + ".dat"))
         {
            _loc1_ = new User();
            _loc1_.scoreReport = null;
            if(agUsername == SaveLoadSystem.adminName)
            {
               _loc1_.gemReport = [10,10,10,10,10,5,5,5,5,5];
               _loc1_.itemReport = [["1-0",200]];
               _loc1_.score = 10000;
            }
            else
            {
               _loc1_.gemReport = null;
               _loc1_.itemReport = null;
               _loc1_.score = 0;
            }
            _loc1_.equipment = new Array();
            _loc1_.report = new Report(_loc1_.scoreReport,SaveLoadSystem.root.gameSpec,_loc1_.gemReport,SaveLoadSystem.root.gemSpec,_loc1_.itemReport,SaveLoadSystem.root.itemSpec);
            _loc1_.username = agUsername;
            _loc1_.password = agUserPass;
            _loc1_.type = !agType ? 1 : agType;
            _loc1_.name = agName;
            _loc1_.gender = agGender;
            _loc1_.school = agSchool;
            _loc1_.edLevel = agEdLevel;
            _loc1_.classLevel = agClassLevel;
            _loc1_.className = agClassName;
            _loc1_.firstHint = true;
            _loc1_.quality = 0;
            _loc1_.winmode = 1;
            _loc1_.musicvolume = 0;
            _loc1_.language = 0;
            _loc1_.extra = 8;
            _loc1_.bossQue = new Array();
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               _loc1_.bossQue.push(new Array());
               _loc2_ = 0;
               while(_loc2_ < 4)
               {
                  _loc1_.bossQue[_loc4_].push(0);
                  _loc2_ = _loc2_ + 1;
               }
               _loc4_ = _loc4_ + 1;
            }
            _loc1_.defeatedBoss = new Array();
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               _loc1_.defeatedBoss.push(0);
               _loc4_ = _loc4_ + 1;
            }
            SaveLoadSystem._filename.splice(_loc3_,0,SaveLoadSystem.savePath + "savedat" + _loc3_ + ".dat");
            SaveLoadSystem._userList.splice(_loc3_,0,_loc1_);
            SaveLoadSystem.saveUserData(_loc1_);
            return true;
         }
         _loc3_ = _loc3_ + 1;
      }
      return false;
   }
   static function validateLogin(agUsername, agUserPass)
   {
      var _loc1_ = 0;
      while(_loc1_ < SaveLoadSystem._userList.length)
      {
         if(SaveLoadSystem._userList[_loc1_].username == agUsername && SaveLoadSystem._userList[_loc1_].password == agUserPass)
         {
            SaveLoadSystem.root.user = SaveLoadSystem.loadUserData(agUsername);
            SaveLoadSystem.notSaveNow = true;
            SaveLoadSystem.root.setUserMusicVolume(SaveLoadSystem.root.user.musicvolume);
            SaveLoadSystem.root.setUserWinMode(SaveLoadSystem.root.user.winmode);
            SaveLoadSystem.root.setUserQuality(SaveLoadSystem.root.user.quality);
            SaveLoadSystem.notSaveNow = false;
            return true;
         }
         _loc1_ = _loc1_ + 1;
      }
      return false;
   }
   static function hasDuplicateUser(agUsername)
   {
      return SaveLoadSystem.loadUserData(agUsername) != null;
   }
   static function numUsers()
   {
      return SaveLoadSystem._userList.length;
   }
   static function loadUserData(agUsername)
   {
      var _loc1_ = 0;
      while(_loc1_ < SaveLoadSystem._userList.length)
      {
         if(SaveLoadSystem._userList[_loc1_].username == agUsername)
         {
            return SaveLoadSystem._userList[_loc1_];
         }
         _loc1_ = _loc1_ + 1;
      }
      return null;
   }
   static function saveUserData(agUser)
   {
      if(agUser == null)
      {
         SaveLoadSystem.mdm.Dialogs.prompt("save null!");
         return undefined;
      }
      if(SaveLoadSystem.notSaveNow || agUser.username == SaveLoadSystem.demoName)
      {
         return undefined;
      }
      var _loc7_ = 0;
      var _loc1_;
      var _loc8_;
      var _loc5_;
      var _loc6_;
      var _loc3_;
      var _loc4_;
      var _loc2_;
      while(_loc7_ < SaveLoadSystem._userList.length)
      {
         _loc1_ = SaveLoadSystem._userList[_loc7_];
         if(_loc1_ == agUser)
         {
            _loc8_ = "// Prince Legend User Record //\r\n" + _loc1_.score + "\r\n" + _loc1_.equipment.join(",") + "\r\n" + _loc1_.username + "\r\n" + _loc1_.password + "\r\n" + _loc1_.type + "\r\n" + SaveLoadSystem.chi2CodeStr(_loc1_.name) + "\r\n" + _loc1_.gender + "\r\n" + SaveLoadSystem.chi2CodeStr(_loc1_.school) + "\r\n" + _loc1_.edLevel + "\r\n" + _loc1_.classLevel + "\r\n" + _loc1_.className + "\r\n" + SaveLoadSystem.nArray2Str(_loc1_.bossQue,",",":") + "\r\n" + _loc1_.defeatedBoss.join(",") + "\r\n" + (!_loc1_.firstHint ? 0 : 1) + "\r\n" + _loc1_.quality + "\r\n" + _loc1_.winmode + "\r\n" + _loc1_.musicvolume + "\r\n" + _loc1_.language + "\r\n" + _loc1_.extra + "\r\n" + SaveLoadSystem.nArray2Str(_loc1_.report.getGemBoard(),",") + "\r\n" + SaveLoadSystem.nArray2Str(_loc1_.report.getItemBoardInArray(),",",":") + "\r\n";
            _loc5_ = _loc1_.report.getScoreBoardInArray();
            _loc6_ = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc5_.length)
            {
               _loc6_.push(new Array());
               _loc4_ = 0;
               while(_loc4_ < _loc5_[_loc3_].length)
               {
                  _loc2_ = _loc5_[_loc3_][_loc4_];
                  _loc6_[_loc3_].push([_loc2_[0],SaveLoadSystem.date2Str(_loc2_[1]),_loc2_[2],SaveLoadSystem.date2Str(_loc2_[3]),_loc2_[4],SaveLoadSystem.date2Str(_loc2_[5])]);
                  _loc4_ = _loc4_ + 1;
               }
               _loc3_ = _loc3_ + 1;
            }
            _loc8_ += SaveLoadSystem.nArray2Str(_loc6_,",","#","$") + "\r\n";
            SaveLoadSystem.saveFile(_loc8_,SaveLoadSystem._filename[_loc7_]);
            return undefined;
         }
         _loc7_ = _loc7_ + 1;
      }
   }
   static function loadLicence()
   {
      var _loc1_ = new Object();
      var _loc2_ = SaveLoadSystem.loadFile(SaveLoadSystem.savePath + "lic.dat");
      if(_loc2_)
      {
         _loc2_ = SaveLoadSystem.codeStr2Chi(_loc2_);
         _loc2_ = _loc2_.split("\r\n");
         _loc1_.name = _loc2_[0];
         _loc1_.phone = _loc2_[1];
         _loc1_.email = _loc2_[2];
         _loc1_.sn = _loc2_[3];
         _loc1_.hdkey = _loc2_[4];
         _loc1_.activationKey = _loc2_[5];
      }
      else
      {
         _loc1_.name = "";
         _loc1_.phone = "";
         _loc1_.email = "";
         _loc1_.sn = "";
         _loc1_.hdkey = "";
         _loc1_.activationKey = "";
      }
      return _loc1_;
   }
   static function saveLicence(_licence)
   {
      var _loc2_ = _licence.name + "\r\n" + _licence.phone + "\r\n" + _licence.email + "\r\n" + _licence.sn + "\r\n" + _licence.hdkey + "\r\n" + _licence.activationKey;
      _loc2_ = SaveLoadSystem.chi2CodeStr(_loc2_);
      SaveLoadSystem.saveFile(_loc2_,SaveLoadSystem.savePath + "lic.dat");
   }
   static function init(mc, _mdm)
   {
      SaveLoadSystem.root = mc;
      SaveLoadSystem.mdm = _mdm;
      SaveLoadSystem.savePath = SaveLoadSystem.mdm.Application.getEnvVar("ALLUSERSPROFILE") + "\\Documents\\Little Prince\\Prince Legend\\";
      SaveLoadSystem.mdm.FileSystem.makeFolder(SaveLoadSystem.savePath);
      var _loc11_ = SaveLoadSystem.mdm.FileSystem.loadFile("version.txt");
      if(_loc11_)
      {
         _loc11_ = _loc11_.split("\r\n");
         SaveLoadSystem.root.verNumber = _loc11_[0];
         if(_loc11_.length > 1)
         {
            SaveLoadSystem.savePath = _loc11_[1];
         }
      }
      else
      {
         SaveLoadSystem.root.verNumber = "1.0";
      }
      SaveLoadSystem._userList = new Array();
      SaveLoadSystem._filename = new Array();
      var _loc9_ = "";
      var _loc7_ = 0;
      var _loc8_;
      while(_loc7_ < 9)
      {
         _loc8_ = SaveLoadSystem.loadFile(SaveLoadSystem.savePath + "savedat" + _loc7_ + ".dat");
         if(_loc8_)
         {
            _loc9_ += _loc8_;
            SaveLoadSystem._filename.push(SaveLoadSystem.savePath + "savedat" + _loc7_ + ".dat");
         }
         _loc7_ = _loc7_ + 1;
      }
      var _loc5_;
      var _loc4_;
      var _loc10_;
      var _loc6_;
      var _loc2_;
      var _loc3_;
      var _loc1_;
      if(_loc9_)
      {
         _loc9_ = _loc9_.split("// Prince Legend User Record //\r\n");
         _loc9_.shift();
         _loc7_ = 0;
         while(_loc7_ < _loc9_.length)
         {
            _loc5_ = _loc9_[_loc7_].split("\r\n");
            _loc4_ = new User();
            _loc10_ = SaveLoadSystem.str2NumArray(_loc5_[19],",");
            _loc6_ = SaveLoadSystem.str2nArray(_loc5_[20],",",":");
            _loc2_ = 0;
            while(_loc2_ < _loc6_.length)
            {
               _loc6_[_loc2_][1] = int(_loc6_[_loc2_][1]);
               _loc2_ = _loc2_ + 1;
            }
            _loc3_ = SaveLoadSystem.str2nArray(_loc5_[21],",","#","$");
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc3_[_loc2_].length)
               {
                  _loc3_[_loc2_][_loc1_][1] = SaveLoadSystem.str2Date(_loc3_[_loc2_][_loc1_][1]);
                  _loc3_[_loc2_][_loc1_][0] = !_loc3_[_loc2_][_loc1_][1] ? null : int(_loc3_[_loc2_][_loc1_][0]);
                  _loc3_[_loc2_][_loc1_][3] = SaveLoadSystem.str2Date(_loc3_[_loc2_][_loc1_][3]);
                  _loc3_[_loc2_][_loc1_][2] = !_loc3_[_loc2_][_loc1_][3] ? null : int(_loc3_[_loc2_][_loc1_][2]);
                  _loc3_[_loc2_][_loc1_][5] = SaveLoadSystem.str2Date(_loc3_[_loc2_][_loc1_][5]);
                  _loc3_[_loc2_][_loc1_][4] = !_loc3_[_loc2_][_loc1_][5] ? null : int(_loc3_[_loc2_][_loc1_][4]);
                  _loc1_ = _loc1_ + 1;
               }
               _loc2_ = _loc2_ + 1;
            }
            _loc4_.report = new Report(_loc3_,SaveLoadSystem.root.gameSpec,_loc10_,SaveLoadSystem.root.gemSpec,_loc6_,SaveLoadSystem.root.itemSpec);
            _loc4_.equipment = _loc5_[1].split(",");
            _loc4_.score = int(_loc5_[0]);
            _loc4_.username = _loc5_[2];
            _loc4_.password = _loc5_[3];
            _loc4_.type = _loc5_[4];
            _loc4_.name = SaveLoadSystem.codeStr2Chi(_loc5_[5]);
            _loc4_.gender = int(_loc5_[6]);
            _loc4_.school = SaveLoadSystem.codeStr2Chi(_loc5_[7]);
            _loc4_.edLevel = int(_loc5_[8]);
            _loc4_.classLevel = int(_loc5_[9]);
            if(_loc4_.edLevel >= 2 || _loc4_.classLevel > 4)
            {
               _loc4_.passRate = 0.8;
            }
            else if(_loc4_.classLevel > 2)
            {
               _loc4_.passRate = 0.7;
            }
            else
            {
               _loc4_.passRate = 0.6;
            }
            _loc4_.className = _loc5_[10];
            _loc4_.bossQue = SaveLoadSystem.str2nArray(_loc5_[11],",",":");
            _loc4_.defeatedBoss = SaveLoadSystem.str2NumArray(_loc5_[12],",");
            _loc4_.firstHint = int(_loc5_[13]) > 0;
            _loc4_.quality = int(_loc5_[14]);
            _loc4_.winmode = int(_loc5_[15]);
            _loc4_.musicvolume = int(_loc5_[16]);
            _loc4_.language = int(_loc5_[17]);
            _loc4_.extra = int(_loc5_[18]);
            SaveLoadSystem._userList.push(_loc4_);
            _loc7_ = _loc7_ + 1;
         }
      }
      SaveLoadSystem.createUser(SaveLoadSystem.adminName,SaveLoadSystem.adminPass,"Admin",1,"管理員",1,6,"A",2,true);
   }
   static function saveFile(str, path)
   {
      SaveLoadSystem.mdm.FileSystem.saveFile(path,SaveLoadSystem.mdm.Encryption.encryptString("sol091204",str));
   }
   static function loadFile(path)
   {
      if(SaveLoadSystem.mdm.FileSystem.fileExists(path))
      {
         return SaveLoadSystem.mdm.Encryption.decryptString("sol091204",SaveLoadSystem.mdm.FileSystem.loadFile(path));
      }
      return null;
   }
   static function chi2CodeStr(str)
   {
      var _loc2_ = "";
      var _loc1_ = 0;
      while(_loc1_ < str.length)
      {
         if(_loc2_ == "")
         {
            _loc2_ = str.charCodeAt(_loc1_);
         }
         else
         {
            _loc2_ += "|" + str.charCodeAt(_loc1_);
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc2_;
   }
   static function codeStr2Chi(strcode)
   {
      var _loc3_ = "";
      var _loc2_ = strcode.split("|");
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         _loc3_ += String.fromCharCode(_loc2_[_loc1_]);
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   static function date2Str(_d)
   {
      if(_d == null)
      {
         return null;
      }
      return _d.getFullYear() + "-" + (_d.getMonth() + 1) + "-" + _d.getDate() + " " + _d.getHours() + ":" + _d.getMinutes() + ":" + _d.getSeconds();
   }
   static function str2Date(_d)
   {
      _d = _d.split(" ");
      if(_d == "null")
      {
         return null;
      }
      _d[0] = _d[0].split("-");
      var _loc2_ = 0;
      while(_loc2_ < _d[0].length)
      {
         _d[0][_loc2_] = int(_d[0][_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      _d[1] = _d[1].split(":");
      _loc2_ = 0;
      while(_loc2_ < _d[1].length)
      {
         _d[1][_loc2_] = int(_d[1][_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      return new Date(_d[0][0],_d[0][1] - 1,_d[0][2],_d[1][0],_d[1][1],_d[1][2],0);
   }
   static function str2NumArray(str, sym)
   {
      var _loc2_ = str.split(sym);
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         _loc2_[_loc1_] = Number(_loc2_[_loc1_]);
         _loc1_ = _loc1_ + 1;
      }
      return _loc2_;
   }
   static function str2nArray(str)
   {
      var _loc2_;
      var _loc5_;
      var _loc4_ = new Array();
      if(arguments.length > 1)
      {
         _loc2_ = str.split(arguments[1]);
      }
      var _loc3_;
      if(arguments.length > 2)
      {
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ < _loc2_.length)
            {
               _loc5_ = _loc4_.length / 2 + 2;
               if(_loc5_ < arguments.length)
               {
                  _loc4_.push(_loc2_);
                  _loc4_.push(_loc3_);
                  _loc2_[_loc3_] = _loc2_[_loc3_].split(arguments[_loc5_]);
                  _loc2_ = _loc2_[_loc3_];
                  _loc3_ = 0;
               }
               else
               {
                  _loc3_ = _loc4_.pop() + 1;
                  _loc2_ = _loc4_.pop();
               }
            }
            else
            {
               if(_loc4_.length == 0)
               {
                  return _loc2_;
               }
               _loc3_ = _loc4_.pop() + 1;
               _loc2_ = _loc4_.pop();
            }
         }
      }
      return _loc2_;
   }
   static function nArray2Str(ary)
   {
      var _loc6_ = 1;
      var _loc5_ = new Array();
      var _loc2_ = 0;
      var _loc4_ = "";
      var _loc7_;
      while(true)
      {
         if(_loc2_ < ary.length)
         {
            if(typeof ary[_loc2_] == "object")
            {
               _loc6_ = _loc6_ + 1;
               _loc5_.push(ary);
               _loc5_.push(_loc2_);
               _loc5_.push(_loc4_);
               ary = ary[_loc2_];
               _loc2_ = 0;
               _loc4_ = "";
            }
            else
            {
               if(_loc2_)
               {
                  _loc4_ += arguments[_loc6_] + ary[_loc2_];
               }
               else
               {
                  _loc4_ = ary[_loc2_];
               }
               _loc2_ = _loc2_ + 1;
            }
         }
         else
         {
            if(_loc5_.length == 0)
            {
               return _loc4_;
            }
            _loc6_ = _loc6_ - 1;
            _loc7_ = _loc5_.pop();
            if(_loc7_ != "")
            {
               _loc4_ = _loc7_ + arguments[_loc6_] + _loc4_;
            }
            _loc2_ = _loc5_.pop() + 1;
            ary = _loc5_.pop();
         }
      }
      return null;
   }
   static function alert(msg)
   {
      SaveLoadSystem.mdm.Dialogs.prompt(msg);
   }
   static function getHDKey()
   {
      return SaveLoadSystem.mdm.System.getHDSerial("c");
   }
   static function haveNetwork()
   {
      return SaveLoadSystem.mdm.Network.checkConnection();
   }
}
