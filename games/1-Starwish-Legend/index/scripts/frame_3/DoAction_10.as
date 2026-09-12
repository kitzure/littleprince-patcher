bossData = new Array();
i = 1;
while(i <= 5)
{
   bossData[i - 1] = new Object();
   i++;
}
bossData[0].hp = 10000;
bossData[0].getItem = [{id:"6-1",amount:1},{id:"6-2",amount:1}];
bossData[1].hp = 17000;
bossData[1].getItem = [{id:"6-3",amount:1},{id:"6-4",amount:1}];
bossData[2].hp = 20000;
bossData[2].getItem = [{id:"5-0",amount:1},{id:"6-0",amount:1}];
bossData[3].hp = 35000;
bossData[4].hp = 10000;
bossData[4].getItem = [{id:"7-0",amount:1},{id:"7-1",amount:1},{id:"7-2",amount:1}];
