function initItemSpec()
{
   itemSpec = new Object();
   i = 1;
   while(i <= 6)
   {
      itemSpec["trader" + i] = new Object();
      itemSpec["trader" + i].dat = new Array();
      i++;
   }
   itemSpec.trader1.dat[0] = {id:"1-0",amount:7,cost:1,pattern:[1,1,1,1,1,1,3,3,7,3,3,7],score:0};
   itemSpec.trader1.dat[1] = {id:"1-1",amount:3,cost:1,pattern:[3,3,3,3,3,3,5,8,5,8,5,8],score:0};
   itemSpec.trader1.dat[2] = {id:"1-2",amount:20,cost:1,pattern:[4,2,4,2,4,2,3,3,3,3,3,3],score:0};
   itemSpec.trader1.dat[3] = {id:"1-3",amount:30,cost:1,pattern:[3,3,3,3,3,3,5,5,4,5,5,4],score:0};
   itemSpec.trader1.dat[4] = {id:"1-4",amount:10,cost:1,pattern:[3,2,5,5,2,3,4,4,6,1,1,6],score:0};
   itemSpec.trader2.dat[0] = {id:"2-0",amount:50,cost:1,pattern:[2,2,2,2,4,5,5,4,2,2,2,2],score:0};
   itemSpec.trader2.dat[1] = {id:"2-1",amount:50,cost:1,pattern:[2,2,2,2,4,4,4,4,2,2,2,2],score:0};
   itemSpec.trader2.dat[2] = {id:"2-2",amount:40,cost:1,pattern:[2,2,2,2,1,3,3,1,2,2,2,2],score:0};
   itemSpec.trader2.dat[3] = {id:"2-3",amount:60,cost:1,pattern:[2,2,2,2,3,5,5,3,2,2,2,2],score:0};
   itemSpec.trader2.dat[4] = {id:"2-4",amount:10,cost:1,pattern:[5,2,2,5,2,5,5,2,5,2,2,5],score:0};
   itemSpec.trader3.dat[0] = {id:"3-0",amount:8,cost:1,pattern:[5,6,5,6,5,6,5,6,5,6,5,6],score:0};
   itemSpec.trader3.dat[1] = {id:"3-1",amount:5,cost:1,pattern:[6,5,5,5,5,5,5,5,5,5,5,5],score:0};
   itemSpec.trader3.dat[2] = {id:"3-2",amount:40,cost:1,pattern:[2,4,5,3,2,4,5,3,2,4,5,3],score:0};
   itemSpec.trader3.dat[3] = {id:"3-3",amount:3,cost:1,pattern:[5,5,5,5,5,9,5,2,9,2,2,9],score:0};
   itemSpec.trader3.dat[4] = {id:"3-4",amount:40,cost:1,pattern:[3,3,5,5,5,5,5,5,5,5,5,5],score:0};
   itemSpec.trader4.dat[0] = {id:"4-0",amount:15,cost:1,pattern:[1,1,2,1,1,3,3,1,1,2,1,1],score:0};
   itemSpec.trader4.dat[1] = {id:"4-1",amount:8,cost:1,pattern:[2,1,7,2,1,7,7,1,2,7,1,2],score:0};
   itemSpec.trader4.dat[2] = {id:"4-2",amount:5,cost:1,pattern:[9,1,1,10,1,1,1,1,10,1,1,9],score:0};
   itemSpec.trader4.dat[3] = {id:"4-3",amount:5,cost:1,pattern:[1,8,1,1,8,1,1,8,1,1,8,1],score:0};
   itemSpec.trader4.dat[4] = {id:"4-4",amount:20,cost:1,pattern:[1,1,3,1,1,3,3,1,1,3,1,1],score:0};
   itemSpec.trader5.dat[0] = {id:"5-0",amount:25,cost:1,pattern:[4,4,4,4,3,4,3,4,1,1,1,1],score:0};
   itemSpec.trader5.dat[1] = {id:"5-1",amount:25,cost:1,pattern:[4,4,4,4,2,2,2,2,1,1,1,1],score:0};
   itemSpec.trader5.dat[2] = {id:"5-2",amount:80,cost:1,pattern:[4,4,4,4,4,4,4,4,4,4,4,4],score:0};
   itemSpec.trader5.dat[3] = {id:"5-3",amount:5,cost:1,pattern:[5,5,5,5,4,4,4,4,4,10,4,10],score:0};
   itemSpec.trader5.dat[4] = {id:"5-4",amount:8,cost:1,pattern:[4,4,4,4,2,5,2,5,9,8,9,8],score:0};
   itemSpec.trader6.dat[0] = {id:"6-0",amount:1,cost:1,pattern:[10,9,10,9,10,9,2,2,2,2,2,2],score:1000};
   itemSpec.trader6.dat[1] = {id:"6-1",amount:1,cost:1,pattern:[3,3,3,3,3,3,3,3,3,3,3,3],score:1000};
   itemSpec.trader6.dat[2] = {id:"6-2",amount:1,cost:1,pattern:[0,0,0,0,0,0,0,0,0,0,0,0],score:1500};
   itemSpec.trader6.dat[3] = {id:"6-3",amount:1,cost:1,pattern:[7,7,7,7,7,7,4,4,4,4,4,4],score:500};
   itemSpec.trader6.dat[4] = {id:"6-4",amount:1,cost:1,pattern:[5,5,10,5,5,10,10,6,6,10,6,6],score:1000};
   itemSpec.trader6.dat[5] = {id:"6-5",amount:1,cost:1,pattern:[2,2,2,2,2,2,4,4,4,4,4,4],score:0};
   itemSpec.trader6.dat[6] = {id:"6-6",amount:1,cost:1,pattern:[0,0,0,0,0,0,0,0,0,0,0,0],score:0};
   itemSpec.trader6.dat[7] = {id:"6-7",amount:1,cost:1,pattern:[1,1,1,1,1,1,8,8,8,8,8,8],score:500};
   itemSpec.trader6.dat[8] = {id:"6-8",amount:1,cost:1,pattern:[5,5,5,5,5,5,4,2,4,2,4,2],score:500};
   itemSpec.trader6.dat[9] = {id:"6-9",amount:1,cost:1,pattern:[0,0,0,0,0,0,0,0,0,0,0,0],score:1000};
   itemSpec.trader6.dat[10] = {id:"6-10",amount:1,cost:1,pattern:[2,2,2,4,4,4,5,5,5,5,5,5],score:0};
}
