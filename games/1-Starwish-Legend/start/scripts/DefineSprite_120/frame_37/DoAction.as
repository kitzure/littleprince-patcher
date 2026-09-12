if(_parent.bossStatus == "question")
{
   _parent.bossQ.startAni();
}
else if(_parent.bossStatus == "start")
{
   _parent.startBossBattle();
}
else
{
   _parent.resumeMapFromBoss();
}
gotoAndStop(1);
