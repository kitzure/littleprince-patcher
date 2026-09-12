function preloadFile(fileArray)
{
   traceOut("preloadFile(" + fileArray.toString() + ")");
   traceOut("verShort:" + verShort);
   loadParam = fileArray;
   var _loc5_;
   var _loc7_;
   var _loc6_;
   var _loc11_;
   var _loc10_;
   var _loc9_;
   var _loc8_;
   var _loc2_;
   var _loc3_;
   if(verShort == "we")
   {
      popup("loading");
      _loc5_ = new Array();
      _loc7_ = new Array();
      _loc6_ = new Array();
      traceOut("filrArray Length:" + fileArray.length);
      var i = 0;
      while(i < fileArray.length)
      {
         _loc5_.push(fileArray[i].file);
         _loc7_.push(fileArray[i].display);
         _loc6_.push(fileArray[i].loc);
         i++;
      }
      _loc11_ = new Array();
      _loc10_ = 0;
      if(ver.substr(0,2) != "cd")
      {
         loadVariablesNum("totalSize.php?path=" + _loc5_.toString(),0);
      }
      traceOut("totalSize:" + _loc10_);
      _loc9_ = {};
      _loc9_.onDone = function()
      {
         this.tmpLoader.unloadMovie();
         showComplete();
      };
      _loc8_ = new lib.LoadQue.LoadQue(_loc9_);
      var loadedSize = new Array();
      var totalFileSize = new Array();
      _loc2_ = 0;
      while(_loc2_ < _loc5_.length)
      {
         loadedSize.push(0);
         totalFileSize.push(0);
         _loc2_ = _loc2_ + 1;
      }
      var i = 0;
      while(i < _loc5_.length)
      {
         var root = this;
         _loc3_ = {};
         _loc3_.mc = this.tmpLoader.createEmptyMovieClip("insertHere_" + i,i);
         _loc3_.mc._visible = false;
         _loc3_.url = _loc5_[i];
         _loc3_.isShown = _loc7_[i];
         _loc3_.mcLoc = _loc6_[i];
         _loc3_.mc.id = i;
         _loc3_.onError = function(errLink)
         {
            showLoadingError(errLink);
         };
         _loc3_.onProgress = function(per, tot)
         {
            if(per == -10 && tot == -10)
            {
               this.onError(this.url);
            }
            if(root.fileSizeArr.indexOf(",") >= 0)
            {
               traceOut("tot: " + tot);
               root.totalSizeArr = root.fileSizeArr.split(",");
            }
            loadedSize[this.mc.id] = per;
            totalFileSize[this.mc.id] = tot;
            var _loc4_ = 0;
            var _loc3_ = 0;
            var _loc2_ = 0;
            while(_loc2_ < fileArray.length)
            {
               _loc4_ += loadedSize[_loc2_];
               if(Number(totalFileSize[_loc2_]) != 0 || root.ver.substr(0,2) == "cd")
               {
                  _loc3_ += Number(totalFileSize[_loc2_]);
               }
               else
               {
                  _loc3_ += Number(root.totalSizeArr[_loc2_]);
               }
               _loc2_ = _loc2_ + 1;
            }
            if(!(per == -10 && tot == -10))
            {
               root.showProgress(_loc4_,_loc3_);
            }
         };
         _loc3_.onDone = function()
         {
            this.mc._visble = false;
            this.mc.unloadMovie();
         };
         _loc8_.queItem(_loc3_);
         i++;
      }
   }
   else
   {
      loadedfile = 0;
      var i = 0;
      while(i <= fileArray.length - 1)
      {
         this.createEmptyMovieClip("holder" + i,this.getNextHighestDepth());
         this["holder" + i]._visible = false;
         this["holder" + i]._y = 3000;
         this.createEmptyMovieClip("holderProgress" + i,this.getNextHighestDepth());
         this["holder" + i].loadMovie(fileArray[i].file);
         this["holderProgress" + i].myID = i;
         this["holderProgress" + i].myFile = fileArray[i].file;
         this["holderProgress" + i].onEnterFrame = function()
         {
            this._parent["holder" + this.myID].gotoAndStop(1);
            this["holder" + i]._visible = false;
            if(this._parent["holder" + this.myID].getBytesLoaded() == this._parent["holder" + this.myID].getBytesTotal())
            {
               loadedfile++;
               delete this.onEnterFrame;
            }
         };
         i++;
      }
      this.createEmptyMovieClip("loadCounter",this.getNextHighestDepth());
      loadCounter.onEnterFrame = function()
      {
         if(loadedfile == loadParam.length)
         {
            showComplete();
            delete this.onEnterFrame;
         }
      };
   }
   traceOut("finish calling loading");
}
function showProgress(loadedBytes, totalBytes)
{
   if(!popedLoading)
   {
      prepareLoadingPopup();
   }
   showLoading([Number(loadedBytes),Number(totalBytes)]);
}
function showComplete()
{
   loadCounter.removeMovieClip();
   i = 0;
   while(i < loadParam.length)
   {
      this["holder" + i].removeMovieClip();
      this["holderProgress" + i].removeMovieClip();
      if(loadParam[i].showNow)
      {
         this[loadParam[i].loc].loadMovie(loadParam[i].file);
      }
      i++;
   }
   killPopup();
   if(completeAction != undefined)
   {
      completeAction();
      delete completeAction;
   }
   System.onStatus = function(infoObject)
   {
      trace(infoObject);
   };
}
function unloadFile(clips)
{
   i = 0;
   while(i < clips.length)
   {
      this[clips[i]].unloadMovie();
      i++;
   }
}
function showLoadingError(errLink)
{
   trace("The file (" + errLink + ") has error.");
   killPopup();
}
