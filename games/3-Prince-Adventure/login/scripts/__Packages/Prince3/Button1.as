class Prince3.Button1 extends Prince3.UI.CheckButton
{
   var _height;
   var _width;
   var _xscale;
   var _yscale;
   var bg;
   var blur;
   var border;
   var checked;
   var highlight;
   var onReleaseOutside;
   var real_height;
   var real_width;
   var tf;
   function Button1()
   {
      super();
      this.onReleaseOutside = this.onRollOut;
   }
   function onLoad()
   {
      super.onLoad();
   }
   function set label(lbl)
   {
      this.setText(lbl);
   }
   function setText(txt)
   {
      var _loc2_ = this._yscale;
      var _loc4_ = this.tf._height;
      this.real_width = this._width;
      this.real_height = this._height;
      this._xscale = this._yscale = 100;
      this.tf._xscale = _loc2_;
      this.tf._yscale = _loc2_;
      var _loc3_ = this._width - this.tf._width;
      this.tf.autoSize = true;
      this.tf.text = txt;
      this.border._width = this.highlight._width = this.bg._width = this.blur._width = _loc3_ + this.tf._width;
      this.border._height = this.highlight._height = this.bg._height = this.blur._height = this.real_height;
      this.tf._x = (this._width - this.tf._width) / 2;
      this.tf._y = (this._height - this.tf._height) / 2;
   }
   function onRelease()
   {
      super.onRelease();
      if(!this.checked)
      {
         this.tf.textColor = 16777215;
      }
   }
   function onRollOver()
   {
      super.onRollOver();
      if(!this.checked)
      {
         this.tf.textColor = 16763904;
      }
   }
   function onRollOut()
   {
      super.onRollOut();
      if(!this.checked)
      {
         this.tf.textColor = 16777215;
      }
   }
}
