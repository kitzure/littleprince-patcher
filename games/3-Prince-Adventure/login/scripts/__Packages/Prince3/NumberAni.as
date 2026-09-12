class Prince3.NumberAni
{
   var end_num;
   var start_num;
   var step;
   function NumberAni(start_num, end_num, step)
   {
      this.start_num = start_num;
      this.end_num = end_num;
      this.step = (end_num - start_num) / step;
   }
   function numberChange()
   {
      this.start_num += this.step;
      if(this.step > 0)
      {
         if(this.start_num > this.end_num)
         {
            this.start_num = this.end_num;
         }
      }
      else if(this.start_num < this.end_num)
      {
         this.start_num = this.end_num;
      }
      return this.start_num;
   }
   function aniFinish()
   {
      return this.start_num == this.end_num;
   }
}
