// Other_11 — fires when the player uses this scroll on an item slot.
//
// "interact_id" = the inventory slot the player clicked/hovered.
// If it's noone, we find the nearest valid slot under the mouse.

audio_play_sound(snd_gui_identification, 2, 0);

if (interact_id == noone)
{
    // 3974 = interaction radius in GUI pixels. o_inv_slot_parent = any slot.
    interact_id = scr_findNearestInstanceDepthExt(global.guiMouseX, global.guiMouseY, 3974, o_inv_slot_parent);
}

var _success = false;

// "with (interact_id)" switches context to the TARGET item slot.
// Inside here, "data", "quality", "identified" etc. = the TARGET item's values.
with (interact_id)
{
    // image_alpha == 1 means this slot is a valid target (set by Other_20 highlight logic).
    // If it's 0.25 the slot is dimmed/invalid and we do nothing.
    if (image_alpha == 1)
    {
        // Step 1: clear any existing enchants on the target item before adding new ones.
        // Char_0 through Char_9 are the enchantment slots on items.
        var _i = 0;
        repeat (10)
        {
            var _key = ("Char_" + string(_i));
            if (ds_map_exists(data, _key)) { ds_map_delete(data, _key); }
            _i++;
        }
        // Clear the colour override too (enchant glow).
        if (ds_map_exists(data, "Colour")) ds_map_delete(data, "Colour");

        // Trigger visual refresh on the target item (updates its sprite/colors).
        event_user(7);

        // Step 2: apply the enchantments.
        // scr_cursed_scroll_random_enchant(count, rank, tier)
        //   count = 2  → adds 2 enchants
        //   rank  = 1  → rare tier (blue, moderate values)
        //   tier  = "rare" → stored on item, used by disenchant scroll later
        ds_map_set(data, "cursed_scroll_tier", "rare");
        scr_cursed_scroll_random_enchant(2, 1, "rare");

        // Trigger visual refresh again after enchants are applied.
        event_user(7);

        if (inmouse)
        {
            scr_guiInteractiveEventPerform(id, 1);
            scr_guiInteractiveEventPerform(id, 0);
        }
        _success = true;
    }
}

// Step 3: if enchanting succeeded, log it and consume the scroll.
if (_success)
{
    with (parent)
    {
        // Writes a line to the action log: "Player used Rare Enchantment Scroll on [item]"
        scr_actionsLog("useItem", [scr_actionsLogGetName(o_player), log_text, scr_actionsLogGetName(id)]);
        // sh_diss = 200 triggers the scroll's dissolve/use animation.
        sh_diss = 200;
    }
    // event_user(0) = "scroll has been used" — this is what actually removes it from inventory.
    event_user(0);
}

interact_id = -4;
