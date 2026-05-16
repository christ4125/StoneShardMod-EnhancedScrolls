// Arguments passed into the function dynamically by your scroll logic items
var _max_stats = argument0;
var _min_stats = argument1;
var _tier_name = argument2;

var _rolls = irandom_range(_min_stats, _max_stats);
ds_map_set(data, "cursed_scroll_tier", _tier_name);

// Tells the engine to roll standard vanilla enchantments based on your counts
repeat(_rolls)
{
    scr_enchant_random(data); 
}
event_user(7);
return 1;
