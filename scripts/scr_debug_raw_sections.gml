/// scr_debug_raw_sections(raw_sections)
var raw_sections = argument0;
for (var i = 0; i < ds_list_size(raw_sections); i++)
{
    var section = raw_sections[| i]; // DS map

    // Read mustHitSection
    var mustHit = false;
    if (ds_map_exists(section, "mustHitSection"))
        mustHit = (section[? "mustHitSection"] != 0);

    // Read typeOfSection
    var typeOfSection = 0;
    if (ds_map_exists(section, "typeOfSection"))
        typeOfSection = section[? "typeOfSection"];

    // Read lengthInSteps
    var lengthInSteps = 0;
    if (ds_map_exists(section, "lengthInSteps"))
        lengthInSteps = section[? "lengthInSteps"];

    show_debug_message("---- SECTION " + string(i) + " ----");
    show_debug_message("mustHitSection = " + string(mustHit));
    show_debug_message("typeOfSection  = " + string(typeOfSection));
    show_debug_message("lengthInSteps  = " + string(lengthInSteps));

    // Read notes
    if (ds_map_exists(section, "sectionNotes"))
    {
        var notes_list = section[? "sectionNotes"];

        for (var j = 0; j < ds_list_size(notes_list); j++)
        {
            var note = notes_list[| j]; // DS list: [time, dir, noteType]

            if (ds_exists(note, ds_type_list))
            {
                var s = "[";
                for (var k = 0; k < ds_list_size(note); k++)
                {
                    s += string(note[| k]);
                    if (k < ds_list_size(note)-1) s += ", ";
                }
                s += "]";
                show_debug_message("Note " + string(j) + ": " + s);
            }
        }
    }
}

