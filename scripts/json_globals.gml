#define json_globals
/// json_globals();
global.json_text = "";
global.json_pos  = 1;

#define json_skip
/// json_skip()
while (global.json_pos <= string_length(global.json_text)) {
    var c = string_char_at(global.json_text, global.json_pos);
    // spaces, tabs, newlines, carriage return
    if (c == " " || ord(c) == 9 || ord(c) == 10 || ord(c) == 13 || ord(c) == 65279 || ord(c) == 160)
        global.json_pos++;
    else
        break;
}

#define json_parse_value
/// json_parse_value()
json_skip();

var c = string_char_at(global.json_text, global.json_pos);
if (c == "{") return json_parse_object();
if (c == "[") return json_parse_array();
if (c == '"') return json_parse_string();
if (c == 't' or c == 'f') return json_parse_boolean();

// default: number
return json_parse_number();



#define json_parse_boolean
///json_parse_boolean()
var start = global.json_pos;
var c = string_char_at(global.json_text, global.json_pos);
if (c == 't')
{
    global.json_pos+=4;
    return 1;
}
else
{
    global.json_pos+=5;
    return 0;
}

#define json_parse_string
/// json_parse_string()
global.json_pos++; // skip "

var start = global.json_pos;

while (global.json_pos <= string_length(global.json_text)) {
    var c = string_char_at(global.json_text, global.json_pos);
    if (c == ',') break;
    if (c == '"') break;
    global.json_pos++;
}

var out = string_copy(global.json_text, start, global.json_pos - start);

global.json_pos++; // skip "
return out;

#define json_parse_number
/// json_parse_number()
var start = global.json_pos;

while (global.json_pos <= string_length(global.json_text)) {
    var c = string_char_at(global.json_text, global.json_pos);
    if ((c >= "0" && c <= "9") || c == ".")
        global.json_pos++;
    else
        break;
}

return real(string_copy(global.json_text, start, global.json_pos - start));

#define json_parse_array
/// json_parse_array()
var arr = ds_list_create();

global.json_pos++; // skip [
json_skip();

if (string_char_at(global.json_text, global.json_pos) == "]") {
    global.json_pos++;
    return arr;
}

while (true) {
    var v = json_parse_value();
    ds_list_add(arr, v);

    json_skip();
    var c = string_char_at(global.json_text, global.json_pos);

    if (c == ",") { global.json_pos++; continue; }
    if (c == "]") { global.json_pos++; break; }
}

return arr;


#define json_parse_object
/// json_parse_object()
var map = ds_map_create();

global.json_pos++; // skip {
json_skip();

if (string_char_at(global.json_text, global.json_pos) == "}") {
    global.json_pos++;
    return map;
}

while (true) {
    var key = json_parse_string();

    json_skip();
    global.json_pos++; // skip :

    var value = json_parse_value();
    ds_map_add(map, key, value);

    json_skip();
    var c = string_char_at(global.json_text, global.json_pos);

    if (c == ",") { global.json_pos++; continue; }
    if (c == "}") { global.json_pos++; break; }
}

return map;


#define json_parse
/// json_parse(str)
// returns ds_map, ds_list, number, or string

global.json_text = argument0;
global.json_pos  = 1;

return json_parse_value();