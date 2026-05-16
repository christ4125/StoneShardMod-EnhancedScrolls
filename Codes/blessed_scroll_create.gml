event_inherited();
inv_object = o_inv_scroll_blessed;
image_blend = make_colour_rgb(255, 255, 255);

// --- THE INSTANT INVENTORY SPAWNER NODE ---
// The absolute second this single item loads in the game world, 
// it forces the player engine instance to create the rest of your custom set!
if (instance_exists(o_player))
{
    // Arguments structure: (GridLocationX, GridLocationY, ItemObjectAssetIndex)
    scr_inventory_add_item(o_player, "scroll_blessed");
    scr_inventory_add_item(o_player, "scroll_legendary_enchantment");
    scr_inventory_add_item(o_player, "scroll_epic_enchantment");
    scr_inventory_add_item(o_player, "scroll_rare_enchantment");
    scr_inventory_add_item(o_player, "scroll_cursed_hexing");
}
