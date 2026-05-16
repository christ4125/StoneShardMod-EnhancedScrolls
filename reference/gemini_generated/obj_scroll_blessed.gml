// --- Section Block 6 ---
event_inherited()
skill = o_skill_blessed_scroll
scr_consum_atr("scroll_blessed")
quality = (7 << 0)
ds_map_set(data, "quality", quality)
ds_map_set(data, "cursed_scroll_bg_color", make_colour_rgb(58, 55, 43))
ds_map_set(data, "cursed_scroll_bg_texture", make_colour_rgb(82, 74, 52))
ds_map_set(data, "cursed_scroll_bg_alpha", 0.25)
base_index = 8
image_blend = make_colour_rgb(255, 238, 180)

// --- Section Block 11 ---
event_inherited()
inv_object = o_inv_scroll_blessed
image_blend = 16777215

// --- Section Block 16 ---
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
        scr_cursed_scroll_random_enchant(5, 4, "blessed")
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