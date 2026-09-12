function restartSys()
{
   delete mapEngine_Current;
   delete mapEngine_From;
   delete bossDefeat;
   delete firstTimeEnter;
   delete mapEngine_x;
   delete mapEngine_y;
   delete onTop;
   hideCursor();
   gotoAndPlay(1);
}
