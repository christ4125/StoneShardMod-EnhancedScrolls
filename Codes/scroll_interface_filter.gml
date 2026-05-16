event_inherited();

with (o_inv_slot) {
    var _quality = ds_map_find_value_ext(data, "quality", -4);
    var _metatype = ds_map_find_value_ext(data, "Metatype", "");
    
    // Highlight conditions: Must not be a trade menu window, must be identified equipment, cannot be cursed
    if (owner.object_index != o_trade_inventory && (_metatype == "Weapon" || _metatype == "Armor") && ds_map_find_value_ext(data, "identified", false) && (!(ds_map_find_value_ext(data, "is_cursed", true))) && _quality != (6 << 0)) {
        image_alpha = 1;
    } else {
        image_alpha = 0.25;
    }
    can_pick = false;
}
