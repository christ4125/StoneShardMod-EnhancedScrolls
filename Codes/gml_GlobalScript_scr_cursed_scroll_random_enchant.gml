// This is the enchant function. It lives as a global script.
// Arguments:
//   argument0 = how many enchants to add (count)
//   argument1 = rank (0=common, 1=rare, 2=epic, 3=legendary, 4=blessed)
//   argument2 = tier string stored on the item e.g. "rare"
//
// It runs "with (interact_id)" context, meaning "data", "quality",
// "identified" etc. all refer to the TARGET item being enchanted.

if (argument0 == undefined)
    argument0 = 1
if (argument1 == undefined)
    argument1 = 0
if (argument2 == undefined)
    argument2 = ""

// Guard 1: skip legendary quality items (they can't be enchanted)
var _quality = ds_map_find_value_ext(data, "quality", -4)
if (_quality == (6 << 0))
    return 0;

// Guard 2: only works on Weapons and Armor
var _metatype = ds_map_find_value_ext(data, "Metatype", "")
if (_metatype != "Weapon" && _metatype != "Armor")
    return 0;

var _rank = max(0, min(argument1, 4))
var _is_weapon_target = _metatype == "Weapon"
var _added = 0
var _attempts = 0

// Keep rolling until we've added the requested count, or give up after 120 tries
// (120 tries prevents infinite loops if all slots are full)
while (_added < argument0 && _attempts < 120)
{
    _attempts++
    var _attribute = ""
    var _value = 0
    var _roll = irandom(_is_weapon_target ? 33 : 41)
    if _is_weapon_target
    {
        switch _roll
        {
            case 0:  _attribute = "Weapon_Damage"         _value = irandom_range(4 + _rank * 2, 7 + _rank * 3)   break
            case 1:  _attribute = "Slashing_Damage"        _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 2:  _attribute = "Piercing_Damage"        _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 3:  _attribute = "Blunt_Damage"           _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 4:  _attribute = "Rending_Damage"         _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 5:  _attribute = "Fire_Damage"            _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 6:  _attribute = "Frost_Damage"           _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 7:  _attribute = "Poison_Damage"          _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 8:  _attribute = "Shock_Damage"           _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 9:  _attribute = "Caustic_Damage"         _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 10: _attribute = "Arcane_Damage"          _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 11: _attribute = "Unholy_Damage"          _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 12: _attribute = "Sacred_Damage"          _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 13: _attribute = "Psionic_Damage"         _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 14: _attribute = "Hit_Chance"             _value = irandom_range(2 + _rank, 4 + _rank * 2)       break
            case 15: _attribute = "CRT"                    _value = irandom_range(1 + _rank, 3 + _rank * 2)       break
            case 16: _attribute = "CRTD"                   _value = irandom_range(8 + _rank * 4, 12 + _rank * 7)  break
            case 17: _attribute = "CTA"                    _value = irandom_range(2 + _rank, 4 + _rank * 2)       break
            case 18: _attribute = "FMB"                    _value = -irandom_range(2 + _rank, 4 + _rank * 2)      break
            case 19: _attribute = "Armor_Piercing"         _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 20: _attribute = "Armor_Damage"           _value = irandom_range(5 + _rank * 3, 9 + _rank * 5)   break
            case 21: _attribute = "Bodypart_Damage"        _value = irandom_range(6 + _rank * 4, 10 + _rank * 6)  break
            case 22: _attribute = "Bleeding_Chance"        _value = irandom_range(2 + _rank, 5 + _rank * 2)       break
            case 23: _attribute = "Daze_Chance"            _value = irandom_range(2 + _rank, 5 + _rank * 2)       break
            case 24: _attribute = "Stun_Chance"            _value = irandom_range(2 + _rank, 5 + _rank * 2)       break
            case 25: _attribute = "Knockback_Chance"       _value = irandom_range(2 + _rank, 5 + _rank * 2)       break
            case 26: _attribute = "Immob_Chance"           _value = irandom_range(2 + _rank, 5 + _rank * 2)       break
            case 27: _attribute = "Stagger_Chance"         _value = irandom_range(2 + _rank, 5 + _rank * 2)       break
            case 28: _attribute = "Magic_Power"            _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 29: _attribute = "Lifesteal"              _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 30: _attribute = "Manasteal"              _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 31: _attribute = "Abilities_Energy_Cost"  _value = -irandom_range(2 + _rank, 4 + _rank * 2)      break
            case 32: _attribute = "Cooldown_Reduction"     _value = -irandom_range(2 + _rank, 4 + _rank * 2)      break
            case 33: _attribute = "Bonus_Range"            _value = irandom_range(1, 1 + floor(_rank / 2))        break
        }
    }
    else
    {
        switch _roll
        {
            case 0:  _attribute = "max_hp"                 _value = irandom_range(4 + _rank * 3, 8 + _rank * 5)   break
            case 1:  _attribute = "MP"                     _value = irandom_range(4 + _rank * 3, 8 + _rank * 5)   break
            case 2:  _attribute = "Health_Restoration"     _value = irandom_range(3 + _rank, 5 + _rank * 2)       break
            case 3:  _attribute = "MP_Restoration"         _value = irandom_range(3 + _rank, 5 + _rank * 2)       break
            case 4:  _attribute = "Healing_Received"       _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 5:  _attribute = "PRR"                    _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 6:  _attribute = "Block_Power"            _value = irandom_range(5 + _rank * 3, 10 + _rank * 5)  break
            case 7:  _attribute = "Block_Recovery"         _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 8:  _attribute = "EVS"                    _value = irandom_range(2 + _rank, 5 + _rank * 2)       break
            case 9:  _attribute = "Crit_Avoid"             _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 10: _attribute = "Damage_Received"        _value = -irandom_range(1 + _rank, 3 + _rank * 2)      break
            case 11: _attribute = "Damage_Returned"        _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 12: _attribute = "Abilities_Energy_Cost"  _value = -irandom_range(2 + _rank, 4 + _rank * 2)      break
            case 13: _attribute = "Cooldown_Reduction"     _value = -irandom_range(2 + _rank, 4 + _rank * 2)      break
            case 14: _attribute = "Magic_Power"            _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 15: _attribute = "Miracle_Chance"         _value = irandom_range(2 + _rank, 4 + _rank * 2)       break
            case 16: _attribute = "Miracle_Power"          _value = irandom_range(4 + _rank * 3, 8 + _rank * 5)   break
            case 17: _attribute = "Miscast_Chance"         _value = -irandom_range(2 + _rank, 4 + _rank * 2)      break
            case 18: _attribute = "Physical_Resistance"    _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 19: _attribute = "Nature_Resistance"      _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 20: _attribute = "Magic_Resistance"       _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 21: _attribute = "Slashing_Resistance"    _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 22: _attribute = "Piercing_Resistance"    _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 23: _attribute = "Blunt_Resistance"       _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 24: _attribute = "Rending_Resistance"     _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 25: _attribute = "Fire_Resistance"        _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 26: _attribute = "Frost_Resistance"       _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 27: _attribute = "Poison_Resistance"      _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 28: _attribute = "Shock_Resistance"       _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 29: _attribute = "Caustic_Resistance"     _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 30: _attribute = "Arcane_Resistance"      _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 31: _attribute = "Unholy_Resistance"      _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 32: _attribute = "Sacred_Resistance"      _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 33: _attribute = "Psionic_Resistance"     _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 34: _attribute = "Stun_Resistance"        _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 35: _attribute = "Knockback_Resistance"   _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 36: _attribute = "Pain_Resistance"        _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 37: _attribute = "Weapon_Damage"          _value = irandom_range(3 + _rank * 2, 6 + _rank * 3)   break
            case 38: _attribute = "Lifesteal"              _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 39: _attribute = "Manasteal"              _value = irandom_range(1 + _rank, 2 + _rank * 2)       break
            case 40: _attribute = "Skills_Energy_Cost"     _value = -irandom_range(2 + _rank, 4 + _rank * 2)      break
            case 41: _attribute = "Spells_Energy_Cost"     _value = -irandom_range(2 + _rank, 4 + _rank * 2)      break
        }
    }

    // Only add if this attribute slot isn't already taken
    if (!(ds_map_exists(data, _attribute)))
    {
        var _slot = 0
        while (!__is_undefined(ds_map_find_value(data, ("Char" + string(_slot)))))
            _slot++
        scr_consum_char_add(_attribute, _value, _slot, false)
        _added++
    }
}

// After adding enchants: set quality, mark identified, set tier and color
if (_added > 0)
{
    quality = (_rank >= 1) ? (3 << 0) : (2 << 0)
    ds_map_set(data, "quality", quality)
    identified = true
    ds_map_set(data, "identified", true)
    if (argument2 != "")
        ds_map_set(data, "cursed_scroll_tier", argument2)
    if (_rank >= 1)
    {
        var _colour = make_colour_rgb(76, 127, 255)       // rank 1 = rare blue
        var _bg_colour = make_colour_rgb(36, 38, 55)
        var _bg_texture = make_colour_rgb(43, 49, 70)
        var _bg_alpha = 0.25
        if (_rank == 2)
        {
            _colour = make_colour_rgb(154, 83, 235)       // rank 2 = epic purple
            _bg_colour = make_colour_rgb(43, 35, 54)
            _bg_texture = make_colour_rgb(55, 43, 70)
        }
        else if (_rank == 3)
        {
            _colour = make_colour_rgb(255, 174, 48)       // rank 3 = legendary gold
            _bg_colour = make_colour_rgb(55, 47, 34)
            _bg_texture = make_colour_rgb(73, 56, 36)
        }
        else if (_rank >= 4)
        {
            _colour = make_colour_rgb(255, 238, 180)      // rank 4 = blessed cream
            _bg_colour = make_colour_rgb(58, 55, 43)
            _bg_texture = make_colour_rgb(82, 74, 52)
        }
        ds_map_set(data, "cursed_scroll_enchant_color", _colour)
        ds_map_set(data, "cursed_scroll_bg_color", _bg_colour)
        ds_map_set(data, "cursed_scroll_bg_texture", _bg_texture)
        ds_map_set(data, "cursed_scroll_bg_alpha", _bg_alpha)
    }
}
return _added
