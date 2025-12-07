///scr_show_score(0-4)
var temp = argument0;
var str = "";

if temp = 0
{
    str = "Miss...";
    score-=10;
    global.life-=4;
    global.combo=0;
}
else if temp = 1
{
    str = "Shit..";
    score+=50;
    global.combo=0;
}
else if temp = 2
{
    str = "Bad.";
    score+=100;
    global.life+=1;
    global.combo=0;
}
else if temp = 3
{
    str = "Good";
    score+=250;
    global.life+=2;
    global.combo++;
}
else
{
    str = "SICK!";
    score+=350;
    global.life+=2;
    global.combo++;
}
if score<=0 score=0;
if global.life>100 global.life=100;
var stata = instance_create(540,360,obj_status);
if global.combo>1 str = str+" x"+string(global.combo)
with stata data=str;
