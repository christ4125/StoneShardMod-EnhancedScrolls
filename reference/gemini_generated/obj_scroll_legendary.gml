// --- Section Block 9 ---
event_inherited()
skill = o_skill_legendary_enchantment_scroll
scr_consum_atr("scroll_legendary_enchantment")
quality = (6 << 0)
ds_map_set(data, "quality", quality)
ds_map_set(data, "cursed_scroll_bg_color", make_colour_rgb(55, 47, 34))
ds_map_set(data, "cursed_scroll_bg_texture", make_colour_rgb(73, 56, 36))
ds_map_set(data, "cursed_scroll_bg_alpha", 0.25)
base_index = 5
image_blend = make_colour_rgb(255, 174, 48)

// --- Section Block 14 ---
event_inherited()
inv_object = o_inv_scroll_legendary_enchantment
image_blend = make_colour_rgb(255, 174, 48)

// --- Section Block 22 ---
event_inherited()
audio_play_sound(snd_gui_identification, 2, 0)
if (interact_id == noone)
    interact_id = scr_findNearestInstanceDepthExt(global.guiMouseX, global.guiMouseY, 3974, o_inv_slot_parent)
var _success = false
with (interact_id)
{
    if (image_alpha == 1)
    {
        scr_cursed_scroll_clear_enchantments()
        scr_cursed_scroll_random_enchant(4, 3, "legendary")
        if inmouse
        {
            scr_guiInteractiveEventPerform(id, 1)
            scr_guiInteractiveEventPerform(id, 0)
        }
        _success = true
    }
}
if _success
{
    with (parent)
    {
        scr_actionsLog("useItem", [scr_actionsLogGetName(o_player), log_text, scr_actionsLogGetName(id)])
        sh_diss = 200
    }
    event_user(0)
}
interact_id = -4