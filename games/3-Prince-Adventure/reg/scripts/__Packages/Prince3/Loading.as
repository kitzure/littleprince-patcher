class Prince3.Loading extends MovieClip
{
   var loadFinishCB;
   var loaded;
   var loadingList;
   var mcl;
   function Loading()
   {
      super();
      trace("loader");
      this._visible = false;
      this.mcl = new MovieClipLoader();
      this.mcl.addListener(this);
   }
   function preload(ary, callBack)
   {
      trace("preload");
      this.loadFinishCB = callBack;
      this._visible = true;
      this.loaded = 0;
      this.loadingList = ary;
      this.loadingList[this.loaded].target.unloadMovie();
      this.mcl.loadClip(this.loadingList[this.loaded].url,this.loadingList[this.loaded].target);
   }
   function onLoadStart(target_mc)
   {
      trace("load start: " + target_mc);
   }
   function onLoadProgress(target_mc, bytesLoaded, bytesTotal)
   {
      trace("loadProgress: " + int(100 * (bytesLoaded / bytesTotal + this.loaded) / this.loadingList.length) + "%");
   }
   function onLoadInit(target_mc)
   {
      trace("loadInit: " + target_mc);
      this.loaded = this.loaded + 1;
      var _loc2_;
      if(this.loaded < this.loadingList.length)
      {
         this.mcl.loadClip(this.loadingList[this.loaded].url,this.loadingList[this.loaded].target);
      }
      else
      {
         trace("load finish");
         this._visible = false;
         if(this.loadFinishCB)
         {
            this.loadFinishCB();
         }
         _loc2_ = 0;
         while(_loc2_ < this.loadingList.length)
         {
            this.loadingList[_loc2_].target.play();
            _loc2_ = _loc2_ + 1;
         }
      }
   }
}
