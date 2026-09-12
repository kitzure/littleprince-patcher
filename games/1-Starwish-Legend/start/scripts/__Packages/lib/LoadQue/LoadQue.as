class lib.LoadQue.LoadQue
{
   var current_obj;
   var doneObj;
   var movie_array;
   var obj;
   var que;
   var working;
   function LoadQue(done_obj)
   {
      this.doneObj = done_obj;
      this.que = [];
      this.obj = {};
      this.working = false;
      this.current_obj = 0;
      this.movie_array = [];
   }
   function queItem(que_obj)
   {
      this.que.push(que_obj);
      if(this.working == false)
      {
         this.working = true;
         this.doLoad();
      }
   }
   function onDone()
   {
   }
   function doLoad()
   {
      var home = this;
      var _loc2_ = {};
      _loc2_.mc = this.que[this.current_obj].mc;
      _loc2_.url = this.que[this.current_obj].url;
      _loc2_.bThick = this.que[this.current_obj].bThick;
      _loc2_.bColor = this.que[this.current_obj].bColor;
      _loc2_.bPad = this.que[this.current_obj].bPad;
      _loc2_.fColor = this.que[this.current_obj].fColor;
      _loc2_.fPad = this.que[this.current_obj].fPad;
      _loc2_.onDone = function(worked)
      {
         home.que[home.current_obj].onDone(worked);
         home.check_next();
      };
      _loc2_.onProgress = function(per, tot)
      {
         home.que[home.current_obj].onProgress(per,tot);
      };
      var _loc3_ = new lib.LoadQue.LoadMovie(_loc2_);
   }
   function check_next()
   {
      this.current_obj = this.current_obj + 1;
      if(this.current_obj == this.que.length)
      {
         this.doneObj.onDone(1);
         this.clearQue();
      }
      else
      {
         this.doLoad();
      }
   }
   function clearQue()
   {
      this.que.length = 0;
      this.working = false;
      this.current_obj = 0;
   }
}
