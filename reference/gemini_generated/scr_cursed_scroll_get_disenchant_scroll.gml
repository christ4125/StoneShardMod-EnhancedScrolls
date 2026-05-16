function scr_cursed_scroll_get_disenchant_scroll()
{
    var _tier = ds_map_find_value_ext(data, "cursed_scroll_tier", "")
    if (_tier == "blessed")
        return __asset_get_index("o_inv_scroll_blessed");
    if (_tier == "legendary")
        return __asset_get_index("o_inv_scroll_legendary_enchantment");
    if (_tier == "epic")
        return __asset_get_index("o_inv_scroll_epic_enchantment");
    if (_tier == "rare")
        return __asset_get_index("o_inv_scroll_rare_enchantment");
    if ds_map_find_value_ext(data, "is_cursed", false)
        return __asset_get_index("o_inv_scroll_cursed_hexing");
    var _quality = ds_map_find_value_ext(data, "quality", -4)
    if (_quality == (3 << 0))
        return __asset_get_index("o_inv_scroll_rare_enchantment");
    if (_quality == (2 << 0))
        return o_inv_scroll_enchant;
    return -4;
}