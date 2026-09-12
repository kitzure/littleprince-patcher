class Prince3.SoundSystem
{
   var start;
   static var lastname;
   static var preLoadComplete;
   static var sound_mc;
   static var __soundSystem = new Prince3.SoundSystem();
   static var maxVal = 100;
   static var preloadlist = new Array();
   static var fadeInOutList = new Array();
   static var loadCompleteFlag = false;
   function SoundSystem()
   {
   }
   static function preloadByArray(filenames)
   {
      if(Prince3.SoundSystem.preloadlist.length)
      {
         Prince3.SoundSystem.preloadlist = Prince3.SoundSystem.preloadlist.concat(filenames);
      }
      else
      {
         Prince3.SoundSystem.preloadlist = Prince3.SoundSystem.preloadlist.concat(filenames);
         Prince3.SoundSystem.preloadByName(Prince3.SoundSystem.preloadlist.splice(0,1)[0]);
      }
   }
   static function preloadByName(filename)
   {
      Prince3.SoundSystem.loadCompleteFlag = false;
      if(!Prince3.SoundSystem.sound_mc)
      {
         Prince3.SoundSystem.sound_mc = _root.createEmptyMovieClip("SoundSystemMC",_root.getNextHighestDepth());
         Prince3.SoundSystem.sound_mc._visible = false;
         Prince3.SoundSystem.sound_mc.onEnterFrame = function()
         {
            Prince3.SoundSystem.onEnterFrame();
         };
      }
      var _loc2_ = Prince3.SoundSystem.nameConvert(filename);
      Prince3.SoundSystem.sound_mc.createEmptyMovieClip("MC_" + _loc2_,Prince3.SoundSystem.sound_mc.getNextHighestDepth());
      Prince3.SoundSystem.sound_mc[_loc2_] = new Sound(Prince3.SoundSystem.sound_mc["MC_" + _loc2_]);
      var _loc3_ = Prince3.SoundSystem.sound_mc[_loc2_];
      _loc3_.onLoad = function()
      {
         Prince3.SoundSystem.loadComplete();
      };
      _loc3_.loadSound(filename + ".mp3");
      Prince3.SoundSystem.lastname = filename;
   }
   static function loadComplete()
   {
      Prince3.SoundSystem.loadCompleteFlag = true;
   }
   static function nameConvert(filename)
   {
      if(filename.lastIndexOf("/") != -1)
      {
         return filename.split("/").join("_");
      }
      return filename;
   }
   static function playVO(filename, callback)
   {
      Prince3.SoundSystem.sound_mc.vo.stop();
      Prince3.SoundSystem.playVO2(filename,callback);
   }
   static function playVO2(filename, callback)
   {
      Prince3.SoundSystem.sound_mc.vo = new Sound(Prince3.SoundSystem.sound_mc);
      Prince3.SoundSystem.sound_mc.vo.onSoundComplete = callback;
      Prince3.SoundSystem.sound_mc.vo.loadSound(filename + ".mp3",true);
      Prince3.SoundSystem.sound_mc.vo.setVolume(100);
   }
   static function playSound(filename, callback)
   {
      var _loc2_ = Prince3.SoundSystem.nameConvert(filename);
      if(filename.indexOf("bgm") == 0)
      {
         Prince3.SoundSystem.sound_mc[_loc2_].setVolume(Prince3.SoundSystem.maxVal);
      }
      else
      {
         Prince3.SoundSystem.sound_mc[_loc2_].setVolume(100);
      }
      Prince3.SoundSystem.sound_mc[_loc2_].start();
      if(callback == "loop")
      {
         Prince3.SoundSystem.sound_mc[_loc2_].onSoundComplete = function()
         {
            this.start();
         };
      }
      else if(callback == null)
      {
         Prince3.SoundSystem.sound_mc[_loc2_].onSoundComplete = null;
      }
      else
      {
         Prince3.SoundSystem.sound_mc[_loc2_].onSoundComplete = callback;
      }
   }
   static function stopVO()
   {
      Prince3.SoundSystem.sound_mc.vo.stop();
   }
   static function stopSound(filename)
   {
      Prince3.SoundSystem.sound_mc[Prince3.SoundSystem.nameConvert(filename)].stop();
   }
   static function allSoundsStop()
   {
      for(var _loc1_ in Prince3.SoundSystem.sound_mc)
      {
         Prince3.SoundSystem.sound_mc[_loc1_].stop();
      }
   }
   static function setVolume(vol, filename)
   {
      var _loc3_ = Prince3.SoundSystem.nameConvert(filename);
      if(vol > Prince3.SoundSystem.maxVal)
      {
         vol = Prince3.SoundSystem.maxVal;
      }
      if(filename == null)
      {
         for(var _loc2_ in Prince3.SoundSystem.sound_mc)
         {
            if(typeof Prince3.SoundSystem.sound_mc[_loc2_] != "movieclip")
            {
               Prince3.SoundSystem.sound_mc[_loc2_].setVolume(vol);
            }
         }
      }
      else
      {
         Prince3.SoundSystem.sound_mc[_loc3_].setVolume(vol);
      }
   }
   static function releaseGameSound()
   {
      for(var _loc1_ in Prince3.SoundSystem.sound_mc)
      {
         if(typeof Prince3.SoundSystem.sound_mc[_loc1_] == "movieclip")
         {
            if(Prince3.SoundSystem.sound_mc[_loc1_]._name.indexOf("MC_vo_game") == 0 || Prince3.SoundSystem.sound_mc[_loc1_]._name.indexOf("MC_pvo_game") == 0)
            {
               Prince3.SoundSystem.sound_mc[_loc1_].removeMovieClip();
            }
         }
         else if(_loc1_.indexOf("vo_game") == 0 || _loc1_.indexOf("pvo_game") == 0)
         {
            Prince3.SoundSystem.sound_mc[_loc1_].stop();
            delete Prince3.SoundSystem.sound_mc[_loc1_];
         }
      }
   }
   static function release()
   {
      for(var _loc1_ in Prince3.SoundSystem.sound_mc)
      {
         if(typeof Prince3.SoundSystem.sound_mc[_loc1_] == "movieclip")
         {
            Prince3.SoundSystem.sound_mc[_loc1_].removeMovieClip();
         }
         else
         {
            Prince3.SoundSystem.sound_mc[_loc1_].stop();
            delete Prince3.SoundSystem.sound_mc[_loc1_];
         }
      }
   }
   static function releaseByArray(filenames)
   {
      var _loc1_ = 0;
      while(_loc1_ < filenames.length)
      {
         Prince3.SoundSystem.releaseByName(filenames[_loc1_]);
         _loc1_ = _loc1_ + 1;
      }
   }
   static function releaseByName(filename)
   {
      Prince3.SoundSystem.preloadlist = new Array();
      var _loc1_ = Prince3.SoundSystem.nameConvert(filename);
      Prince3.SoundSystem.sound_mc[_loc1_].stop();
      delete Prince3.SoundSystem.sound_mc[_loc1_];
      Prince3.SoundSystem.sound_mc["MC_" + _loc1_].removeMovieClip();
   }
   static function fadeInOut(filename, step, tvol)
   {
      var _loc2_ = Prince3.SoundSystem.nameConvert(filename);
      var _loc1_ = 0;
      while(_loc1_ < Prince3.SoundSystem.fadeInOutList.length)
      {
         if(Prince3.SoundSystem.fadeInOutList[_loc1_].name == _loc2_)
         {
            Prince3.SoundSystem.fadeInOutList.splice(_loc1_,1);
            _loc1_ = _loc1_ - 1;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(Prince3.SoundSystem.sound_mc[_loc2_].getVolume() > tvol)
      {
         Prince3.SoundSystem.fadeInOutList.push({name:_loc2_,val:- Prince3.SoundSystem.maxVal / step,tvol:tvol});
      }
      else if(Prince3.SoundSystem.sound_mc[_loc2_].getVolume() < tvol)
      {
         Prince3.SoundSystem.fadeInOutList.push({name:_loc2_,val:Prince3.SoundSystem.maxVal / step,tvol:tvol});
      }
   }
   static function fadeIn(filename, step)
   {
      var _loc3_ = Prince3.SoundSystem.nameConvert(filename);
      var _loc1_ = 0;
      while(_loc1_ < Prince3.SoundSystem.fadeInOutList.length)
      {
         if(Prince3.SoundSystem.fadeInOutList[_loc1_].name == _loc3_)
         {
            Prince3.SoundSystem.fadeInOutList.splice(_loc1_,1);
            _loc1_ = _loc1_ - 1;
         }
         _loc1_ = _loc1_ + 1;
      }
      Prince3.SoundSystem.playSound(filename,"loop");
      Prince3.SoundSystem.setVolume(0,filename);
      if(Prince3.SoundSystem.maxVal != 0)
      {
         Prince3.SoundSystem.fadeInOutList.push({name:Prince3.SoundSystem.nameConvert(filename),val:Prince3.SoundSystem.maxVal / step,tvol:Prince3.SoundSystem.maxVal});
      }
   }
   static function fadeOut(filename, step)
   {
      var _loc2_ = Prince3.SoundSystem.nameConvert(filename);
      var _loc1_ = 0;
      while(_loc1_ < Prince3.SoundSystem.fadeInOutList.length)
      {
         if(Prince3.SoundSystem.fadeInOutList[_loc1_].name == _loc2_)
         {
            Prince3.SoundSystem.fadeInOutList.splice(_loc1_,1);
            _loc1_ = _loc1_ - 1;
         }
         _loc1_ = _loc1_ + 1;
      }
      Prince3.SoundSystem.setVolume(Prince3.SoundSystem.maxVal,filename);
      if(Prince3.SoundSystem.maxVal != 0)
      {
         Prince3.SoundSystem.fadeInOutList.push({name:_loc2_,val:(- Prince3.SoundSystem.maxVal) / step,tvol:0});
      }
      else
      {
         Prince3.SoundSystem.sound_mc[_loc2_].stop();
      }
   }
   static function onEnterFrame()
   {
      var _loc1_ = 0;
      var _loc2_;
      var _loc3_;
      while(_loc1_ < Prince3.SoundSystem.fadeInOutList.length)
      {
         _loc2_ = Prince3.SoundSystem.sound_mc[Prince3.SoundSystem.fadeInOutList[_loc1_].name];
         _loc3_ = _loc2_.getVolume() + Prince3.SoundSystem.fadeInOutList[_loc1_].val;
         if(Prince3.SoundSystem.fadeInOutList[_loc1_].val > 0)
         {
            if(_loc3_ >= Prince3.SoundSystem.fadeInOutList[_loc1_].tvol)
            {
               _loc2_.setVolume(Prince3.SoundSystem.fadeInOutList[_loc1_].tvol);
               Prince3.SoundSystem.fadeInOutList.splice(_loc1_,1);
               _loc1_ = _loc1_ - 1;
            }
            else
            {
               _loc2_.setVolume(_loc3_);
            }
         }
         else if(_loc3_ <= Prince3.SoundSystem.fadeInOutList[_loc1_].tvol)
         {
            if(Prince3.SoundSystem.fadeInOutList[_loc1_].tvol == 0)
            {
               _loc2_.stop();
            }
            else
            {
               _loc2_.setVolume(Prince3.SoundSystem.fadeInOutList[_loc1_].tvol);
            }
            Prince3.SoundSystem.fadeInOutList.splice(_loc1_,1);
            _loc1_ = _loc1_ - 1;
         }
         else
         {
            _loc2_.setVolume(_loc3_);
         }
         _loc1_ = _loc1_ + 1;
      }
      if(Prince3.SoundSystem.loadCompleteFlag)
      {
         Prince3.SoundSystem.loadCompleteFlag = false;
         if(Prince3.SoundSystem.lastname.lastIndexOf("vo/game") == 0 || Prince3.SoundSystem.lastname.lastIndexOf("pvo/game") == 0)
         {
            Prince3.SoundSystem.releaseByName(Prince3.SoundSystem.lastname);
         }
         if(Prince3.SoundSystem.preloadlist.length == 0)
         {
            Prince3.SoundSystem.preLoadComplete();
         }
         else
         {
            Prince3.SoundSystem.preloadByName(Prince3.SoundSystem.preloadlist.splice(0,1)[0]);
         }
      }
   }
}
