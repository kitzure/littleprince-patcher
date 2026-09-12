class Prince3.Utils
{
   function Utils()
   {
   }
   static function drawWedge(mc, x, y, startAngle, arc, xRadius, yRadius)
   {
      var _loc13_;
      var _loc3_;
      var _loc2_;
      var _loc5_;
      var _loc10_;
      mc.moveTo(x,y);
      yRadius = yRadius != undefined ? yRadius : xRadius;
      while(arc < -360)
      {
         arc += 360;
      }
      while(arc > 360)
      {
         arc -= 360;
      }
      _loc10_ = Math.ceil(Math.abs(arc) / 45);
      _loc13_ = arc / _loc10_;
      _loc3_ = Prince3.Utils.deg2Rad(- _loc13_);
      _loc2_ = Prince3.Utils.deg2Rad(- startAngle);
      var _loc4_;
      if(_loc10_ > 0)
      {
         mc.lineTo(x + Math.cos(Prince3.Utils.deg2Rad(startAngle)) * xRadius,y + Math.sin(Prince3.Utils.deg2Rad(- startAngle)) * yRadius);
         _loc4_ = 0;
         while(_loc4_ < _loc10_)
         {
            _loc2_ += _loc3_;
            _loc5_ = _loc2_ - _loc3_ / 2;
            mc.curveTo(x + Math.cos(_loc5_) * (xRadius / Math.cos(_loc3_ / 2)),y + Math.sin(_loc5_) * (yRadius / Math.cos(_loc3_ / 2)),x + Math.cos(_loc2_) * xRadius,y + Math.sin(_loc2_) * yRadius);
            _loc4_ = _loc4_ + 1;
         }
         mc.lineTo(x,y);
      }
   }
   static function strRev(str)
   {
      var _loc1_ = str.split("");
      _loc1_.reverse();
      return _loc1_.join("");
   }
   static function distance(x1, y1, x2, y2)
   {
      var _loc1_ = x1 - x2;
      var _loc2_ = y1 - y2;
      return Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
   }
   static function p2pAngle(cx, cy, dx, dy)
   {
      return Prince3.Utils.posAngle(Prince3.Utils.rad2Deg(Math.atan2(dx - cx,cy - dy)));
   }
   static function posAngle(angle)
   {
      while(angle < 0)
      {
         angle += 360;
      }
      while(angle > 360)
      {
         angle -= 360;
      }
      return angle;
   }
   static function deg2Rad(deg)
   {
      return deg * 3.141592653589793 / 180;
   }
   static function rad2Deg(rad)
   {
      return rad * 180 / 3.141592653589793;
   }
   static function randomQNumber(num)
   {
      return Prince3.PrinceSystem.random(num) * (!Prince3.PrinceSystem.random(2) ? -1 : 1);
   }
   static function nArray()
   {
      var _loc2_;
      var _loc5_;
      var _loc3_ = new Array();
      if(arguments.length)
      {
         _loc2_ = new Array(arguments[0]);
      }
      var _loc4_;
      if(arguments.length > 1)
      {
         _loc4_ = 0;
         while(true)
         {
            if(_loc4_ < _loc2_.length)
            {
               _loc5_ = _loc3_.length / 2 + 1;
               if(_loc5_ < arguments.length)
               {
                  _loc3_.push(_loc2_);
                  _loc3_.push(_loc4_);
                  _loc2_[_loc4_] = new Array(arguments[_loc5_]);
                  _loc2_ = _loc2_[_loc4_];
                  _loc4_ = 0;
               }
               else
               {
                  _loc4_ = _loc3_.pop() + 1;
                  _loc2_ = _loc3_.pop();
               }
            }
            else
            {
               if(_loc3_.length == 0)
               {
                  return _loc2_;
               }
               _loc4_ = _loc3_.pop() + 1;
               _loc2_ = _loc3_.pop();
            }
         }
      }
      return _loc2_;
   }
   static function str2Date(str)
   {
      if(str == null || str.length < 8)
      {
         return null;
      }
      var _loc1_ = str.split(" ");
      _loc1_[0] = _loc1_[0].split("-");
      _loc1_[1] = _loc1_[1].split(":");
      return new Date(int(_loc1_[0][0]),int(_loc1_[0][1]) - 1,int(_loc1_[0][2]),int(_loc1_[1][0]),int(_loc1_[1][1]),int(_loc1_[1][2]),0);
   }
   static function date2Str(d)
   {
      if(d)
      {
         return d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
      }
      return "";
   }
   static function str2nArray(str)
   {
      var _loc2_;
      var _loc5_;
      var _loc4_ = new Array();
      if(arguments.length > 1)
      {
         _loc2_ = str.split(arguments[1]);
      }
      var _loc3_;
      if(arguments.length > 2)
      {
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ < _loc2_.length)
            {
               _loc5_ = _loc4_.length / 2 + 2;
               if(_loc5_ < arguments.length)
               {
                  _loc4_.push(_loc2_);
                  _loc4_.push(_loc3_);
                  _loc2_[_loc3_] = _loc2_[_loc3_].split(arguments[_loc5_]);
                  _loc2_ = _loc2_[_loc3_];
                  _loc3_ = 0;
               }
               else
               {
                  _loc3_ = _loc4_.pop() + 1;
                  _loc2_ = _loc4_.pop();
               }
            }
            else
            {
               if(_loc4_.length == 0)
               {
                  return _loc2_;
               }
               _loc3_ = _loc4_.pop() + 1;
               _loc2_ = _loc4_.pop();
            }
         }
      }
      return _loc2_;
   }
   static function nArray2Str(ary)
   {
      var _loc6_ = 1;
      var _loc5_ = new Array();
      var _loc2_ = 0;
      var _loc4_ = "";
      var _loc7_;
      while(true)
      {
         if(_loc2_ < ary.length)
         {
            if(typeof ary[_loc2_] == "object")
            {
               _loc6_ = _loc6_ + 1;
               _loc5_.push(ary);
               _loc5_.push(_loc2_);
               _loc5_.push(_loc4_);
               ary = ary[_loc2_];
               _loc2_ = 0;
               _loc4_ = "";
            }
            else
            {
               if(_loc2_)
               {
                  _loc4_ += arguments[_loc6_] + ary[_loc2_];
               }
               else
               {
                  _loc4_ = ary[_loc2_];
               }
               _loc2_ = _loc2_ + 1;
            }
         }
         else
         {
            if(_loc5_.length == 0)
            {
               return _loc4_;
            }
            _loc6_ = _loc6_ - 1;
            _loc7_ = _loc5_.pop();
            if(_loc7_ != "")
            {
               _loc4_ = _loc7_ + arguments[_loc6_] + _loc4_;
            }
            _loc2_ = _loc5_.pop() + 1;
            ary = _loc5_.pop();
         }
      }
      return null;
   }
   static function num2Str(num, format, len)
   {
      var _loc1_ = num.toString(format);
      while(_loc1_.length < len)
      {
         _loc1_ = "0" + _loc1_;
      }
      return _loc1_;
   }
   static function numLimit(num, min, max)
   {
      return num >= min ? (num <= max ? num : max) : min;
   }
   static function createIntArray(num)
   {
      var _loc4_ = arguments.length <= 1 ? 0 : arguments[1];
      var _loc3_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < num)
      {
         _loc3_.push(_loc2_ + _loc4_);
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   static function randomArray(in_ary)
   {
      var _loc1_ = in_ary.concat();
      var _loc2_ = new Array();
      while(_loc1_.length)
      {
         _loc2_.push(_loc1_.splice(Prince3.PrinceSystem.random(_loc1_.length),1)[0]);
      }
      return _loc2_;
   }
   static function 兩斜率交角中的銳角(m1, m2)
   {
      return Prince3.Utils.rad2Deg(Math.atan(Math.abs((m1 - m2) / (1 + m1 * m2))));
   }
   static function 直線方程(x1, y1, x2, y2)
   {
      var _loc1_ = (x1 - x2) / (y1 - y2);
      return {m:_loc1_,c:- x1 + y1 * _loc1_};
   }
   static function 點線距(x, y, in_直線方程)
   {
      var _loc1_ = in_直線方程.m;
      return Math.abs((x + _loc1_ * y + in_直線方程.c) / Math.sqrt(1 + _loc1_ * _loc1_));
   }
   static function 角度差(ang1, ang2)
   {
      var _loc1_ = ang2 - ang1;
      if(_loc1_ > 180)
      {
         return _loc1_ - 360;
      }
      if(_loc1_ < -180)
      {
         return _loc1_ + 360;
      }
      return _loc1_;
   }
   static function arrayRL(in_ary, turn)
   {
      var _loc1_ = in_ary.concat();
      turn %= _loc1_.length;
      return _loc1_.concat(_loc1_.splice(0,turn));
   }
   static function arrayRR(in_ary, turn)
   {
      turn %= in_ary.length;
      return Prince3.Utils.arrayRL(in_ary,in_ary.length - turn);
   }
   static function ASCII2KeyCode(asciiCode)
   {
      if(97 <= asciiCode && asciiCode <= 122)
      {
         return asciiCode - 32;
      }
      if(65 <= asciiCode && asciiCode <= 90 || 48 <= asciiCode && asciiCode <= 57)
      {
         return asciiCode;
      }
      return -1;
   }
}
