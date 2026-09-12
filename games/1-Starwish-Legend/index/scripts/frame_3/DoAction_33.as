function prepareQuit(type)
{
   if(popupStatus != "quit")
   {
      popupStatus = "quit";
      if(type == "application")
      {
         popup("question",["確定要離開嗎?",quit,resumeMap],true);
      }
      else if(type == "logout")
      {
         popup("question",["確定要登出嗎?",logout,resumeMap],true);
      }
   }
}
function logout()
{
   restartSys();
}
function quit()
{
   mdm.Forms.MainForm.visible = false;
   getCurrentResolution();
   var _loc1_;
   if(user.oriResX != 800 and user.oriResY != 600)
   {
      if(currentResX != user.oriResX and currentResY != user.oriResY)
      {
         _loc1_ = mdm.System.setResolution(user.oriResX,user.oriResY);
      }
   }
   mdm.Application.exit();
   fscommand("quit");
   if(verShort == "we")
   {
      getURL("javascript:window.close();");
   }
}
