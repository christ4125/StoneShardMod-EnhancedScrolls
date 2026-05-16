function scr_cursed_scroll_clear_curse()
{
    if ds_map_exists(data, "Curse")
        ds_map_delete(data, "Curse")
    if (ds_map_exists(data, "cursed_scroll_bg_color"))
        ds_map_delete(data, "cursed_scroll_bg_color")
    if (ds_map_exists(data, "cursed_scroll_bg_texture"))
        ds_map_delete(data, "cursed_scroll_bg_texture")
    if (ds_map_exists(data, "cursed_scroll_bg_alpha"))
        ds_map_delete(data, "cursed_scroll_bg_alpha")
    is_cursed = false
    ds_map_set(data, "is_cursed", false)
    cursedName = "N/A"
    cursedDesc = "N/A"
    if instance_exists(o_player)
        scr_atr_calc(o_player)
    return 1;
}