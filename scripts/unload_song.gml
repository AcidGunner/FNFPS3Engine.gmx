///unload_song();
// what else do you think it does??
var path = working_directory + "songs/"+global.song_name+"/";

//Destroy chart
ds_map_destroy(global.chart);

//Destroy sprites
sprite_delete(global.icon0_0);
sprite_delete(global.icon0_1);
sprite_delete(global.icon1_0);
sprite_delete(global.icon1_1);

//Destroy music
audio_destroy_stream(global.inst_stream);
if file_exists(path + "voices.ogg")
    audio_destroy_stream(global.voices_stream);

//Destroy objects
with obj_game instance_destroy();
with obj_receptor instance_destroy();

//Go back to menu without reseting the WHOLE game
instance_create(0,0,obj_menu);
