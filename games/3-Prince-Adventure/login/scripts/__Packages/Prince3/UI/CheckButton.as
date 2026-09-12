class Prince3.UI.CheckButton extends MovieClip
{
   var checked;
   var isCheckButton;
   var onReleaseOutside;
   var onSelect;
   function CheckButton()
   {
      super();
      this.onReleaseOutside = this.onRollOut;
   }
   function onLoad()
   {
      this.gotoAndStop(!this.checked ? "normal" : "checked");
   }
   function onPress()
   {
      if(!this.checked)
      {
         Prince3.PrinceSystem.actionCapture(this,"onPress");
         this.gotoAndStop("press");
      }
   }
   function onRelease()
   {
      if(!this.checked)
      {
         Prince3.PrinceSystem.actionCapture(this,"onRelease");
         if(this.isCheckButton)
         {
            this.checked = true;
            this.gotoAndStop("checked");
         }
         else
         {
            this.gotoAndStop("normal");
         }
         this.onSelect();
      }
   }
   function onRollOver()
   {
      if(!this.checked)
      {
         Prince3.PrinceSystem.actionCapture(this,"onRollOver");
         this.gotoAndStop("over");
      }
   }
   function onRollOut()
   {
      if(!this.checked)
      {
         Prince3.PrinceSystem.actionCapture(this,"onRollOut");
         this.gotoAndStop("normal");
      }
   }
}
