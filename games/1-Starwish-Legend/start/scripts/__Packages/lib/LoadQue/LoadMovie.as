class lib.LoadQue.LoadMovie
{
   var b_mc;
   var calc_mc;
   var f_mc;
   var home;
   var img_mc;
   var mc;
   var obj;
   function LoadMovie(imgObj)
   {
      imgObj.home = this;
      this.mc = imgObj.mc;
      this.calc_mc = this.mc.createEmptyMovieClip("calc_mc",1);
      this.calc_mc.obj = imgObj;
      this.calc_mc.checkTot = 0;
      this.calc_mc.onEnterFrame = this.calc;
      this.img_mc = this.mc.createEmptyMovieClip("img_mc",2);
      this.img_mc.loadMovie(imgObj.url);
      imgObj.onBorderCall = function()
      {
         this.home.createBorder(imgObj.bThick,imgObj.bColor,imgObj.bPad,imgObj.fColor,imgObj.fPad);
      };
   }
   function calc()
   {
      var _loc4_ = this.obj.mc.img_mc;
      var _loc2_ = _loc4_.getBytesLoaded();
      var _loc3_ = _loc4_.getBytesTotal();
      var _loc5_ = Math.round(_loc2_ / _loc3_ * 100);
      if(_loc2_ == 0 and _loc3_ == -1)
      {
         this.obj.mc.calc_mc.checkTot += Number(_loc3_);
      }
      if(_loc2_ > -1 && _loc5_ > 0)
      {
         this.obj.onProgress(_loc2_,_loc3_);
      }
      if(_loc5_ == 100 && _loc4_._width > 0 || _loc2_ == _loc3_)
      {
         this.obj.onBorderCall(1);
         this.obj.callBorder();
         this.obj.onDone(this.obj.home);
         this.obj.mc.calc_mc.onEnterFrame = null;
         delete this.obj.mc.calc_mc;
      }
   }
   function createBorder(b_Thick, b_Color, b_Pad, f_Color, f_Pad)
   {
      this.mc.border_mc.removeMovieClip();
      this.b_mc = this.mc.createEmptyMovieClip("border_mc",3);
      var _loc5_ = this.img_mc._width;
      var _loc4_ = this.img_mc._height;
      var _loc3_ = b_Thick / 2 + b_Pad;
      this.b_mc.lineStyle(b_Thick,b_Color);
      this.b_mc.moveTo(- _loc3_,- _loc3_);
      this.b_mc.lineTo(_loc5_ + _loc3_,- _loc3_);
      this.b_mc.lineTo(_loc5_ + _loc3_,_loc4_ + _loc3_);
      this.b_mc.lineTo(- _loc3_,_loc4_ + _loc3_);
      this.b_mc.lineTo(- _loc3_,- _loc3_);
      if(f_Color != null)
      {
         this.f_mc = this.mc.createEmptyMovieClip("fill_mc",-1);
         if(f_Pad)
         {
            _loc3_ += f_Pad;
         }
         _root.debug_txt.text = "pad :: " + _loc3_;
         this.f_mc.beginFill(f_Color);
         this.f_mc.moveTo(- _loc3_,- _loc3_);
         this.f_mc.lineTo(_loc5_ + _loc3_,- _loc3_);
         this.f_mc.lineTo(_loc5_ + _loc3_,_loc4_ + _loc3_);
         this.f_mc.lineTo(- _loc3_,_loc4_ + _loc3_);
         this.f_mc.lineTo(- _loc3_,- _loc3_);
         this.f_mc.endFill();
      }
   }
}
