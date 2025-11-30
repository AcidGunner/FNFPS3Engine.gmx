/// scr_load_song(chart_json_path)
/// Returns ds_list of notes ready to spawn

// Read JSON file
var f = file_text_open_read(argument0);
var txt = "";
while (!file_text_eof(f)) {
    txt += file_text_read_string(f);
    file_text_readln(f);
}
file_text_close(f);
show_debug_message("loading chart please wait..");

// parse JSON (your parser already returns DS maps/lists)
global.chart = json_parse(txt); // must return DS map
show_debug_message("loading chart done!");
show_debug_message("preparing the song data..");

// set info
var song_map = global.chart[? "song"]; // should be DS map
if (ds_map_exists(song_map, "bpm"))
{
    global.bpm = song_map[? "bpm"];
    global.sec_per_beat = 60 / global.bpm;
}
global.sec_per_beat = 60 / global.bpm;
global.scroll_speed = song_map[? "speed"] * 4;
global.stage_player1 = song_map[? "player1"];
global.stage_player2 = song_map[? "player2"];

global.song_delay = 5 * global.sec_per_beat;
global.song_started = false;

// create list for all notes
var final_notes = ds_list_create();

if (ds_map_exists(song_map, "notes"))
{
    var raw_sections = song_map[? "notes"];
}

for (var i = 0; i < ds_list_size(raw_sections); i++)
{
    var section = raw_sections[| i];
    
    var mustHit = 0; // default
    if (ds_map_exists(section, "mustHitSection"))
    {
        var val = section[? "mustHitSection"];
        mustHit = (val != 0); // convert 0/1 to false/true
    }
    
    var sectionNotes = section[? "sectionNotes"];

    for (var j = 0; j < ds_list_size(sectionNotes); j++)
    {
        var note_array = sectionNotes[| j];

        var time_ms   = note_array[| 0];
        var dir       = note_array[| 1];
        var noteType  = note_array[| 2];

        var player_note;
        if (mustHit)
            player_note = (dir < 4);
        else
            player_note = (dir >= 4);
            
        // Create DS map for the note
        var new_note = ds_map_create();
        new_note[? "time"]      = time_ms / 1000;
        new_note[? "dir"] = dir mod 4;     // convert 4–7 → 0–3
        new_note[? "noteType"]  = noteType;
        new_note[? "isPlayer"]    = player_note;  // <-- SAVE PLAYER/OPPONENT HERE
        new_note[? "spawned"]   = false;

        ds_list_add(final_notes, new_note);
    }
}

// store notes globally
global.notes = final_notes;
show_debug_message("preparing song data complete!");

return final_notes;
