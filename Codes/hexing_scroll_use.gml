// hexing_scroll_use.gml
audio_play_sound(snd_gui_identification, 2, 0);

if (interact_id == noone) {
    interact_id = scr_findNearestInstanceDepthExt(global.guiMouseX, global.guiMouseY, 3974, o_inv_slot_parent);
}

var _success = false;

with (interact_id) {
    if (image_alpha == 1) {
        // FIXED: Calls your cleanly named global function!
        apply_hexing_curse();
        is_cursed = true;
        ds_map_replace(data, "is_cursed", true);
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
