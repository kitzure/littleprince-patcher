function showCursor(which)
{
   if(which == "reuse")
   {
      if(currentCursor == undefined)
      {
         Mouse.show();
      }
      else
      {
         cursor.gotoAndStop(currentCursor);
         startDrag(cursor,1);
         Mouse.hide();
      }
   }
   else
   {
      cursor.gotoAndStop(which);
      startDrag(cursor,1);
      currentCursor = which;
      Mouse.hide();
   }
   if(bossStatus != "question" and currentCursor != undefined)
   {
      onMouseMove = function()
      {
         cursor._x = _xmouse;
         cursor._y = _ymouse;
         if(!header.hitTest(_root._xmouse,_root._ymouse,true) and !gameBar.hitTest(_root._xmouse,_root._ymouse,true))
         {
            cursor.gotoAndStop(which);
            Mouse.hide();
         }
         else
         {
            cursor.gotoAndStop(1);
            Mouse.show();
         }
      };
   }
}
function hideCursor(remain)
{
   cursor.gotoAndStop(1);
   cursor._x = -100;
   cursor._y = -100;
   delete onMouseMove;
   if(!remain)
   {
      delete currentCursor;
   }
   Mouse.show();
}
