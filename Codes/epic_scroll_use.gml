audio_play_sound(snd_gui_identification, 2, 0);

if (interact_id == noone) {
    interact_id = scr_findNearestInstanceDepthExt(global.guiMouseX, global.guiMouseY, 3974, o_inv_slot_parent);
}

var _success = false;

with (interact_id) {
    if (image_alpha == 1) {
        var _i = 0;
        repeat (10) {
            var _key = ("Char_" + string(_i));
            if (ds_map_exists(data, _key)) { ds_map_delete(data, _key); }
            _i++;
        }
        if (ds_map_exists(data, "Colour")) ds_map_delete(data, "Colour");
        event_user(7);
        
        var _rolls = irandom_range(2, 3);
        ds_map_set(data, "cursed_scroll_tier", "epic");
        
        // FIXED: Using vanilla camelCase layout routine
        repeat(_rolls) { scr_enchantRandom(data); }
        event_user(7);

        if (inmouse) {
            scr_guiInteractiveEventPerform(id, 1);
            scr_guiInteractiveEventPerform(id, 0);
        }
        _success = true;
    }
}

if (_success) {
    with (parent) {
        scr_actionsLog("useItem", [scr_actionsLogGetName(o_player), log_text, scr_actionsLogGetName(id)]);
        sh_diss = 200;
    }
    event_user(0);
}
interact_id = -4;
