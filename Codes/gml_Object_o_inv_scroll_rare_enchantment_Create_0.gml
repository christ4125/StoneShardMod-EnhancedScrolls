// Create_0 — runs when this inventory item is instantiated
//
// event_inherited() calls the parent (o_inv_scroll_parent) Create event.
// That parent sets up all the base scroll properties: data map, consum_atr, etc.
// WITHOUT this line the item has no stats, no tooltip, nothing works.
event_inherited();

// Tell the game which inventory object represents this scroll.
// Used when the loot version (o_loot_*) gets picked up — it converts to this.
inv_object = o_inv_scroll_rare_enchantment;

// Blue tint on the scroll sprite. rank 1 = rare blue.
image_blend = make_colour_rgb(76, 127, 255);
