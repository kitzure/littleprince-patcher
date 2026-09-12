if(_parent.bossStatus == "question")
{
   _parent.callBossQuestion();
}
else if(_parent.bossStatus == "start")
{
   _parent.callBossBattle();
}
else
{
   _parent.loadMapFromBoss();
}
stop();
