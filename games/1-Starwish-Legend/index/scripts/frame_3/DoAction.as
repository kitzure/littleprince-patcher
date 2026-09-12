function initSystem(agVersion)
{
   traceOut("initSystem:" + agVersion);
   initSys(agVersion);
   initMapObj();
   initGameSpec();
   initHiddenGemSpec();
   initRestrictLevel();
   initGemSpec();
   initItemSpec();
   traceOut("go to 2" + this._currentframe);
   this.gotoAndStop("GameStart");
   traceOut("went to 2" + this._currentframe);
}
