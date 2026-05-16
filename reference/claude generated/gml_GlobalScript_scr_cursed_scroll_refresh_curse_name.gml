function scr_cursed_scroll_refresh_curse_name()
{
    var _curse_list = ds_map_find_value(data, "Curse")
    if (__is_undefined(_curse_list))
    {
        cursedName = "N/A"
        cursedDesc = "N/A"
        return 0;
    }

    var _curse = ds_list_find_value(_curse_list, 0)
    var _fallback = "N/A"
    switch _curse
    {
        case "Curse_of_Gorelust":
            _fallback = "Curse of Bloodlust"
            break
        case "Curse_of_Soulstealer":
            _fallback = "Curse of Wasting"
            break
        case "Curse_of_Mindwrecker":
            _fallback = "Curse of Madness"
            break
        case "Curse_of_Everfear":
            _fallback = "Curse of Terror"
            break
        case "Curse_of_Gnawmaw":
            _fallback = "Curse of Voracity"
            break
        case "Curse_of_Sufferjoy":
            _fallback = "Curse of Suffering"
            break
        case "Curse_of_Loudmouth":
            _fallback = "Curse of Numbness"
            break
        case "Curse_of_Goldhoarder":
            _fallback = "Curse of Stagnation"
            break
        case "Curse_of_AshenFeast":
            _fallback = "Curse of Ashen Feast"
            break
        case "Curse_of_CrimsonPact":
            _fallback = "Curse of the Crimson Pact"
            break
        case "Curse_of_IronThirst":
            _fallback = "Curse of Iron Thirst"
            break
        case "Curse_of_GraveMercy":
            _fallback = "Curse of Grave Mercy"
            break
        case "Curse_of_StarvedFocus":
            _fallback = "Curse of Starved Focus"
            break
        case "Curse_of_GlassHeart":
            _fallback = "Curse of the Glass Heart"
            break
        case "Curse_of_HollowVigor":
            _fallback = "Curse of Hollow Vigor"
            break
        case "Curse_of_Boneward":
            _fallback = "Curse of the Boneward"
            break
    }

    var _name = ds_map_find_value_ext(global.curse_name, _curse, _fallback)
    if (__is_undefined(_name) || _name == "N/A")
        _name = _fallback
    cursedName = _name
    cursedDesc = "N/A"
    return 1;
}