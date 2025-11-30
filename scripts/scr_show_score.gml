///scr_show_score(0-4)
var temp = argument0;
var str = "";

if temp = 0
{
    str = "Miss..."
    score-=10
    global.life-=4;
}
else if temp = 1
{
    str = "Shit.."
    score+=50
}
else if temp = 2
{
    str = "Bad."
    score+=100
    global.life+=1;
}
else if temp = 3
{
    str = "Good"
    score+=250
    global.life+=2;
}
else
{
    str = "SICK!"
    score+=350
    global.life+=2;
}
if score<=0 score=0;
if global.life<0 game_end();
if global.life>100 global.life=100;
var stata = instance_create(600,360,obj_status);
with stata data=str;
