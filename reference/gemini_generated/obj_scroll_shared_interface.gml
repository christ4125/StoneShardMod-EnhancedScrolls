// --- Section Block 7 ---
event_inherited()
skill = o_skill_cursed_hexing
scr_consum_atr("scroll_cursed_hexing")
quality = (5 << 0)
ds_map_set(data, "quality", quality)
ds_map_set(data, "cursed_scroll_bg_color", make_colour_rgb(47, 31, 36))
ds_map_set(data, "cursed_scroll_bg_texture", make_colour_rgb(64, 38, 45))
ds_map_set(data, "cursed_scroll_bg_alpha", 0.25)
base_index = 0

// --- Section Block 17 ---
event_inherited()
with (o_inv_slot)
{
    var _quality = ds_map_find_value_ext(data, "quality", -4)
    var _metatype = ds_map_find_value_ext(data, "Metatype", "")
    if (owner.object_index != o_trade_inventory && (_metatype == "Weapon" || _metatype == "Armor") && ds_map_find_value_ext(data, "identified", false) && (!(ds_map_find_value_ext(data, "is_cursed", true))) && _quality != (6 << 0))
        image_alpha = 1
    else
        image_alpha = 0.25
    can_pick = false
}

// --- Section Block 19 ---
event_inherited()
with (o_inv_slot)
{
    var _quality = ds_map_find_value_ext(data, "quality", -4)
    var _metatype = ds_map_find_value_ext(data, "Metatype", "")
    if (owner.object_index != o_trade_inventory && (_metatype == "Weapon" || _metatype == "Armor") && ds_map_find_value_ext(data, "identified", false) && (!(ds_map_find_value_ext(data, "is_cursed", true))) && _quality != (6 << 0))
        image_alpha = 1
    else
        image_alpha = 0.25
    can_pick = false
}

// --- Section Block 21 ---
event_inherited()
with (o_inv_slot)
{
    var _quality = ds_map_find_value_ext(data, "quality", -4)
    var _metatype = ds_map_find_value_ext(data, "Metatype", "")
    if (owner.object_index != o_trade_inventory && (_metatype == "Weapon" || _metatype == "Armor") && ds_map_find_value_ext(data, "identified", false) && (!(ds_map_find_value_ext(data, "is_cursed", true))) && _quality != (6 << 0))
        image_alpha = 1
    else
        image_alpha = 0.25
    can_pick = false
}

// --- Section Block 23 ---
event_inherited()
with (o_inv_slot)
{
    var _quality = ds_map_find_value_ext(data, "quality", -4)
    var _metatype = ds_map_find_value_ext(data, "Metatype", "")
    if (owner.object_index != o_trade_inventory && (_metatype == "Weapon" || _metatype == "Armor") && ds_map_find_value_ext(data, "identified", false) && (!(ds_map_find_value_ext(data, "is_cursed", true))) && _quality != (6 << 0))
        image_alpha = 1
    else
        image_alpha = 0.25
    can_pick = false
}

// --- Section Block 25 ---
event_inherited()
with (o_inv_slot)
{
    var _quality = ds_map_find_value_ext(data, "quality", -4)
    var _metatype = ds_map_find_value_ext(data, "Metatype", "")
    if (owner.object_index != o_trade_inventory && (_metatype == "Weapon" || _metatype == "Armor") && ds_map_find_value_ext(data, "identified", false) && (!(ds_map_find_value_ext(data, "is_cursed", true))) && _quality != (6 << 0))
        image_alpha = 1
    else
        image_alpha = 0.25
    can_pick = false
}