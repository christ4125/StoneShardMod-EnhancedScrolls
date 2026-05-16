if ds_map_exists(data, "Curse")
{
    var _curse_list = ds_map_find_value(data, "Curse");
    if (!is_undefined(_curse_list) && ds_list_size(_curse_list) > 0)
    {
        var _curse_id = ds_list_find_value(_curse_list, 0);
        // Dynamically forces the item UI to update its hover text display properties
        cursedName = global.localization_map[? _curse_id];
        cursedDesc = global.localization_map[? _curse_id + "_d"];
    }
}
