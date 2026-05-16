// Other_20 — fires for every inventory slot while this scroll is held/active.
// Its job: highlight VALID slots (alpha=1) and dim INVALID ones (alpha=0.25).
//
// Valid target = identified Weapon or Armor that isn't legendary quality.
// (Legendary items (6<<0) are protected from enchanting.)

var _quality = ds_map_find_value_ext(data, "quality", -4);
var _metatype = ds_map_find_value_ext(data, "Metatype", "");
var _identified = ds_map_find_value_ext(data, "identified", false);

if (owner.object_index != o_trade_inventory
    && (_metatype == "Weapon" || _metatype == "Armor")
    && _identified
    && _quality != (6 << 0))
{
    image_alpha = 1;       // valid target — full brightness
}
else
{
    image_alpha = 0.25;    // invalid target — dimmed
    can_pick = false;
}
