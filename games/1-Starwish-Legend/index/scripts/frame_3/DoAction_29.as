function updateBoss(agBossID)
{
   user.setDefeatedBoss(agBossID);
   saveUserData(user);
}
function updateBossQue(agBossID, agQueID, agItemArr)
{
   user.setBossQue(agBossID,agQueID);
   var _loc1_ = 0;
   while(_loc1_ < agItemArr.length)
   {
      user.report.reduceItem(agItemArr[_loc1_],1);
      _loc1_ = _loc1_ + 1;
   }
   saveUserData(user);
}
