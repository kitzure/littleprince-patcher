var my_so = SharedObject.getLocal("prince2set","/");
if(my_so.data.userList == undefined)
{
   my_so.data.userList = new Array();
}
my_so.flush();
