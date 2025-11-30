/// load_song(songname)
// loads song, duh.
global.song_name = argument0;
var path = working_directory + "songs/"+argument0+"/";
var inst_path = path + "inst.ogg";
var chart_path = path + global.difficulty + ".json";
show_debug_message("Loading " + chart_path);
scr_load_song(chart_path);

// Load music
global.inst_stream = audio_create_stream(inst_path);
global.stream = -1;
global.voices_stream = -1;

if file_exists(path + "voices.ogg")
{
    voices_path = path + "voices.ogg";
    global.voices_stream = audio_create_stream(voices_path);
}
