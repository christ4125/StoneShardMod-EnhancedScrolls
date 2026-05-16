var _i = 0;
repeat (10) 
{
    var _key = ("Char_" + string(_i));
    var _enchant = ds_map_find_value(data, _key);
    if (!is_undefined(_enchant)) 
    {
        var _parts = string_split_custom(_enchant);
        if (array_length(_parts) > 0) 
        {
            ds_map_delete(data, _parts[0]);
        }
        ds_map_delete(data, _key);
    }
    _i++;
}
if (ds_map_exists(data, "cursed_scroll_tier")) ds_map_delete(data, "cursed_scroll_tier");
if (ds_map_exists(data, "cursed_scroll_enchant_color")) ds_map_delete(data, "cursed_scroll_enchant_color");
if (ds_map_exists(data, "cursed_scroll_bg_color")) ds_map_delete(data, "cursed_scroll_bg_color");
if (ds_map_exists(data, "cursed_scroll_bg_texture")) ds_map_delete(data, "cursed_scroll_bg_texture");
if (ds_map_exists(data, "cursed_scroll_bg_alpha")) ds_map_delete(data, "cursed_scroll_bg_alpha");
if (ds_map_exists(data, "Colour")) ds_map_delete(data, "Colour");
event_user(7);
