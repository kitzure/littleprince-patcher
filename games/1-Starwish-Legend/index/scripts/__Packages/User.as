class User
{
   var bossQue;
   var classLevel;
   var className;
   var defeatedBoss;
   var edLevel;
   var equipment;
   var extra;
   var firstHint;
   var gender;
   var language;
   var musicvolume;
   var name;
   var passRate;
   var password;
   var quality;
   var report;
   var school;
   var score;
   var type;
   var username;
   var winmode;
   function User()
   {
   }
   function setUser(agUser)
   {
      this.report.setScoreBoard(agUser.report.getScoreBoardInArray());
      this.report.setGemBoard(agUser.report.getGemBoard());
      this.report.setItemBoard(agUser.report.getItemBoardInArray());
      this.report.setSpec(null,null);
      this.equipment = agUser.equipment.slice(0);
      this.passRate = agUser.passRate;
      this.score = agUser.score;
      this.username = agUser.username;
      this.password = agUser.password;
      this.type = agUser.type;
      this.name = agUser.name;
      this.gender = agUser.gender;
      this.school = agUser.school;
      this.edLevel = agUser.edLevel;
      this.classLevel = agUser.classLevel;
      this.className = agUser.className;
      this.bossQue = agUser.bossQue.slice(0);
      this.defeatedBoss = agUser.defeatedBoss.slice(0);
      this.firstHint = agUser.firstHint;
      this.quality = agUser.quality;
      this.winmode = agUser.winmode;
      this.musicvolume = agUser.musicvolume;
      this.language = agUser.language;
      this.extra = agUser.extra;
   }
   function setBossQue(agBossID, agQueID)
   {
      this.bossQue[agBossID - 1][agQueID - 1] = 1;
   }
   function getBossQue(agBossID)
   {
      return this.bossQue[agBossID - 1].slice(0);
   }
   function setDefeatedBoss(agBossID)
   {
      this.defeatedBoss[agBossID - 1] = 1;
   }
   function hasDefeatedBoss(agBossID)
   {
      if(this.defeatedBoss[agBossID - 1] == 1)
      {
         return true;
      }
      return false;
   }
   function getDefeatedBossNum()
   {
      var _loc3_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < 3)
      {
         if(this.defeatedBoss[_loc2_] == 1)
         {
            _loc3_ = _loc3_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
}
