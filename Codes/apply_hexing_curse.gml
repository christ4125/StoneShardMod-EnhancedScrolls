if (ds_map_exists(data, "Curse")) 
{ 
    ds_map_delete(data, "Curse"); 
}

var curse_list = ds_list_create();
ds_map_add_list(data, "Curse", curse_list);

var _pool = irandom(1);
var _curse = "";

if (_pool == 0) 
{
    _curse = choose("Curse_of_Gorelust", "Curse_of_Soulstealer", "Curse_of_Mindwrecker", "Curse_of_Everfear", "Curse_of_Gnawmaw", "Curse_of_Sufferjoy", "Curse_of_Loudmouth", "Curse_of_Goldhoarder", "Curse_of_AshenFeast");
} 
else 
{
    _curse = choose("Curse_of_CrimsonPact", "Curse_of_IronThirst", "Curse_of_GraveMercy", "Curse_of_StarvedFocus", "Curse_of_GlassHeart", "Curse_of_HollowVigor", "Curse_of_Boneward", "Curse_of_Misfortune");
}

ds_list_add(curse_list, _curse, -4);

switch (_curse) 
{
    case "Curse_of_Gorelust": 
        scr_curse_add_value("CRT", 15); 
        scr_curse_add_value("max_hp", (-0.2 * o_player.max_hp)); 
        break;
    case "Curse_of_Soulstealer": 
        scr_curse_add_value("Manasteal", 20); 
        scr_curse_add_value("Fatigue_Gain", 25); 
        break;
    case "Curse_of_Mindwrecker": 
        scr_curse_add_value("Magic_Power", 25); 
        scr_curse_add_value("Miscast_Chance", 8); 
        break;
    case "Curse_of_Everfear": 
        scr_curse_add_value("Damage_Received", -7); 
        scr_curse_add_value("Hit_Chance", -5); 
        break;
    case "Curse_of_Gnawmaw": 
        scr_curse_add_value("Lifesteal", 15); 
        scr_curse_add_value("Hunger_Resistance", -33); 
        break;
    case "Curse_of_Sufferjoy": 
        scr_curse_add_value("Weapon_Damage", 25); 
        scr_curse_add_value("Pain_Resistance", -33); 
        break;
    case "Curse_of_Loudmouth": 
        scr_curse_add_value("Pain_Resistance", 35); 
        scr_curse_add_value("Cooldown_Reduction", -10); 
        break;
    case "Curse_of_Goldhoarder": 
        scr_curse_add_value("Damage_Received", -8); 
        scr_curse_add_value("Healing_Received", -30); 
        break;
    case "Curse_of_AshenFeast": 
        scr_curse_add_value("Fire_Damage", 10); 
        scr_curse_add_value("Hunger_Resistance", -25); 
        break;
    case "Curse_of_CrimsonPact": 
        scr_curse_add_value("Lifesteal", 15); 
        scr_curse_add_value("Healing_Received", -22); 
        break;
    case "Curse_of_IronThirst": 
        scr_curse_add_value("Armor_Piercing", 20); 
        scr_curse_add_value("FMB", -8); 
        break;
    case "Curse_of_GraveMercy": 
        scr_curse_add_value("Damage_Received", -7); 
        scr_curse_add_value("max_hp", (-0.15 * o_player.max_hp)); 
        break;
    case "Curse_of_StarvedFocus": 
        scr_curse_add_value("Magic_Power", 25); 
        scr_curse_add_value("Miscast_Chance", 8); 
        break;
    case "Curse_of_GlassHeart": 
        scr_curse_add_value("CRTD", 30); 
        scr_curse_add_value("Damage_Received", 5); 
        break;
    case "Curse_of_HollowVigor": 
        scr_curse_add_value("MP", 25); 
        scr_curse_add_value("Pain_Resistance", -22); 
        break;
    case "Curse_of_Boneward": 
        scr_curse_add_value("Physical_Resistance", 15); 
        scr_curse_add_value("EVS", -6); 
        break;
    case "Curse_of_Misfortune": 
        scr_curse_add_value("Counter_Chance", 10); 
        scr_curse_add_value("Strum_Chance", -12); 
        break;
}

ds_map_set(data, "quality", 5); 
ds_map_set(data, "cursed_scroll_bg_color", make_colour_rgb(47, 31, 36));
ds_map_set(data, "cursed_scroll_bg_texture", make_colour_rgb(64, 38, 45));
ds_map_set(data, "cursed_scroll_bg_alpha", 0.25);

is_cursed = true;
ds_map_set(data, "is_cursed", true);

if (ds_map_exists(data, "Curse"))
{
    var _curse_list = ds_map_find_value(data, "Curse");
    if (!is_undefined(_curse_list) && ds_list_size(_curse_list) > 0)
    {
        var _curse_id = ds_list_find_value(_curse_list, 0);
        cursedName = ds_map_find_value(global.localization_map, _curse_id);
        cursedDesc = ds_map_find_value(global.localization_map, _curse_id + "_d");
    }
}

if (instance_exists(o_player)) 
{ 
    scr_atr_calc(o_player); 
}
return 1;
