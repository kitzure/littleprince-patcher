function initFx()
{
   _global.fx = new Object();
   fxArray = ["sel1","sel2","sel3","sel4","sel5","sel6","sel7","sel8","mapin","mapout","bob","slide","stone","togame","walk","transin","fall","score","scoreminus","drag","drop","ding"];
   i = 0;
   while(i <= fxArray.length - 1)
   {
      _global.fx[fxArray[i]] = new Sound();
      _global.fx[fxArray[i]].loadSound("fx/" + fxArray[i] + ".mp3");
      i++;
   }
}
function createFx(which)
{
   if(_global.fx[which] == undefined)
   {
      _global.fx[which] = new Sound();
      _global.fx[which].loadSound("fx/" + which + ".mp3");
   }
}
function playFx(which)
{
   _global.fx[which].start();
}
function stopFx(which)
{
   _global.fx[which].stop();
}
function playMusic(file, loop)
{
   if(channel1 != file and channel2 != file)
   {
      if(channel1 == "none")
      {
         readyChannel = 1;
      }
      else
      {
         readyChannel = 2;
      }
      this["channel" + readyChannel] = file;
      _global["music" + readyChannel].loadSound("music/" + file + ".mp3",false);
      if(verShort == "cd")
      {
         this["musicChecker" + readyChannel].onEnterFrame = function()
         {
            if(_global["music" + readyChannel].getBytesLoaded() == _global["music" + readyChannel].getBytesTotal())
            {
               delete this.onEnterFrame;
               setUserMusicVolume(user.musicvolume);
               _global["music" + readyChannel].start(0,loop);
               usedChannel = readyChannel;
               delete readyChannel;
            }
         };
      }
      else
      {
         _global["music" + readyChannel].onLoad = function()
         {
            setUserMusicVolume(user.musicvolume);
            _global["music" + readyChannel].start(0,loop);
            usedChannel = readyChannel;
            delete readyChannel;
         };
      }
   }
}
function fadeOutMusic(channel, duration)
{
   trace("fading music:" + channel + "/channel1:" + channel1 + "/channel2:" + channel2);
   if(channel1 == channel)
   {
      outChannel = 1;
   }
   else if(channel2 == channel)
   {
      outChannel = 2;
   }
   divVolume = Math.ceil(100 / duration);
   this["musicChecker" + outChannel].onEnterFrame = function()
   {
      if(_global["music" + outChannel].getVolume() - divVolume <= 0)
      {
         _global["music" + outChannel].stop();
         _global["music" + outChannel].setVolume(user.musicvolume);
         this._parent["channel" + outChannel] = "none";
         delete this.onEnterFrame;
      }
      else
      {
         _global["music" + outChannel].setVolume(_global["music" + outChannel].getVolume() - divVolume);
      }
   };
}
function fadeOutBossMusic()
{
   if(bossStatus == "preBoss")
   {
      fadeOutMusic("map" + mapEngine_Current,15);
   }
   else if(bossStatus == "question" or bossStatus == "leaveQuestion")
   {
      fadeOutMusic("question",15);
   }
   else if(bossStatus == "start")
   {
      fadeOutMusic("boss",15);
   }
   else if(bossStatus == "quit" or bossStatus == "end" or bossStatus == "success" or bossStatus == "fail")
   {
      if(mapEngine_Current == "A" or mapEngine_Current == "B" or mapEngine_Current == "C")
      {
         fadeOutMusic("boss",15);
      }
      else if(mapEngine_Current == "E")
      {
         fadeOutMusic("shadow",15);
      }
      else
      {
         fadeOutMusic("final",15);
      }
   }
}
function playBossMusic()
{
   if(bossStatus == "question")
   {
      playMusic("question",10000);
   }
   else if(bossStatus == "start")
   {
      if(mapEngine_Current == "A" or mapEngine_Current == "B" or mapEngine_Current == "C")
      {
         playMusic("boss",10000);
      }
      else if(mapEngine_Current == "E")
      {
         playMusic("shadow",10000);
      }
      else
      {
         playMusic("final",10000);
      }
   }
}
_global.music1 = new Sound();
_global.music2 = new Sound();
