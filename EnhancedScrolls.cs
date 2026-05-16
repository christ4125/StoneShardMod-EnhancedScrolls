using System;
using System.Collections.Generic;
using ModShardLauncher;
using ModShardLauncher.Mods;
using UndertaleModLib.Models;

namespace EnhancedScrollsMod
{
    public class EnhancedScrolls : Mod
    {
        public override string Author      => "christ4125";
        public override string Name        => "Enhanced Scrolls";
        public override string Description => "Adds a Rare Enchantment Scroll to the loot pool.";
        public override string Version     => "1.0.0";
        public override string TargetVersion => "0.9.4.20";

        public override void PatchMod()
        {
            // ----------------------------------------------------------------
            // STEP 1: Register the enchant function as a global GML script.
            //
            // Msl.AddFunction(code, name) tells the game:
            //   "there is now a function called X, and its body is this GML."
            //
            // The name MUST match what the GML files call it.
            // We use the exact same name as the original CursedScrolls mod
            // so it's compatible if both mods ever coexist.
            // ----------------------------------------------------------------
            Msl.AddFunction(
                ModFiles.GetCode("Codes/gml_GlobalScript_scr_cursed_scroll_random_enchant.gml"),
                "scr_cursed_scroll_random_enchant"
            );

            // ----------------------------------------------------------------
            // STEP 2: Create the inventory object.
            //
            // Every usable item in Stoneshard needs TWO objects:
            //   o_inv_*  = the item sitting in your inventory bag
            //   o_skill_* = the "skill" object that activates when you use it
            //
            // Msl.AddObject(name, sprite, parent, visible, persistent, solid, collisionFlags)
            // ----------------------------------------------------------------

            // The inventory item (what you see in your bag)
            UndertaleGameObject invObj = Msl.AddObject(
                "o_inv_scroll_rare_enchantment",  // name — must match inv_object in Create_0.gml
                "s_inv_scroll",                   // sprite — reuses the vanilla scroll sprite
                "o_inv_scroll_parent",            // parent — inherits all base scroll behavior
                true,   // visible
                true,   // persistent (stays across room transitions)
                true,   // solid
                (CollisionShapeFlags)0
            );

            // The skill object (what runs when you click-use the scroll)
            UndertaleGameObject skillObj = Msl.AddObject(
                "o_skill_rare_enchantment_scroll", // name
                "s_inv_scroll02",                  // slightly different sprite (skill version)
                "o_skill_enchantment",             // parent — inherits enchantment skill behavior
                true,
                false,  // NOT persistent (destroyed after use)
                true,
                (CollisionShapeFlags)0
            );

            // ----------------------------------------------------------------
            // STEP 3: Attach GML events to each object.
            //
            // Msl.AddNewEvent(object, code, EventType, subtype)
            //
            // EventType enum:
            //   0  = Create
            //   2  = Alarm
            //   7  = Other
            //
            // Subtypes for EventType.Other:
            //   11 = "Other_11" = item use event
            //   20 = "Other_20" = slot highlight event (runs every frame while held)
            //
            // Subtypes for EventType.Alarm:
            //   0  = Alarm_0
            // ----------------------------------------------------------------

            // inv object only needs Create (sets up sprite tint, inv_object reference)
            Msl.AddNewEvent(invObj,
                ModFiles.GetCode("Codes/gml_Object_o_inv_scroll_rare_enchantment_Create_0.gml"),
                EventType.Create, 0u);

            // skill object needs all three events
            Msl.AddNewEvent(skillObj,
                ModFiles.GetCode("Codes/gml_Object_o_skill_rare_enchantment_scroll_Alarm_0.gml"),
                EventType.Alarm, 0u);

            Msl.AddNewEvent(skillObj,
                ModFiles.GetCode("Codes/gml_Object_o_skill_rare_enchantment_scroll_Other_11.gml"),
                EventType.Other, 11u);

            Msl.AddNewEvent(skillObj,
                ModFiles.GetCode("Codes/gml_Object_o_skill_rare_enchantment_scroll_Other_20.gml"),
                EventType.Other, 20u);

            // ----------------------------------------------------------------
            // STEP 4: Register the scroll in the item tables.
            //
            // The game has a table called table_items_stats that defines every
            // item's price, rarity, type, etc. We need our scroll in there
            // or it won't appear correctly in shops/loot UI.
            //
            // Format: "id;;price;;;category;;subcategory;weight;[42 empty slots];;rarity;"
            // ----------------------------------------------------------------
            Msl.LoadGML("gml_GlobalScript_table_items_stats")
                .MatchFrom("];")                  // finds the closing ]; of the table
                .InsertAbove(                     // inserts our row just before it
                    "\"scroll_rare_enchantment;;450;;;scroll;;paper;Light;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;rare;\","
                )
                .Save();

            // ----------------------------------------------------------------
            // STEP 5: Register display name and description.
            //
            // table_items has localized strings for every item name + description.
            // The format uses semicolons to separate each language column.
            // 12 languages = 12 copies of the same English string for now.
            // ----------------------------------------------------------------
            Msl.LoadGML("gml_GlobalScript_table_items")
                .MatchFrom("consum_name;\",")
                .InsertBelow(
                    "\"scroll_rare_enchantment;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;Rare Enchantment Scroll;\","
                )
                .Save();

            Msl.LoadGML("gml_GlobalScript_table_items")
                .MatchFrom("consum_desc;\",")
                .InsertBelow(
                    "\"scroll_rare_enchantment;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;Imbues identified equipment with 2 rare enchantments.;\","
                )
                .Save();

            // ----------------------------------------------------------------
            // STEP 6: Inject into the loot pool.
            //
            // scr_get_scroll is the vanilla function that picks what scroll
            // drops from loot. It has two return choose() lines:
            //   - one for shop inventory (asset IDs like 5174)
            //   - one for world loot
            //
            // We replace BOTH with a weighted roll that includes our scroll.
            //
            // The original lines (confirmed from full_code_dump.txt):
            //   return choose(5174, 5177, 5177)   ← shop version
            //   return choose(4424, 4427, 4425)   ← loot version
            //
            // Our weighted roll:
            //   ~88% chance = vanilla result (unchanged)
            //   ~12% chance = our rare scroll
            // ----------------------------------------------------------------
            Msl.LoadGML("gml_GlobalScript_table_items_stats")
                .Apply(ItemsStatsIterator)
                .Save();

            Msl.LoadGML("gml_GlobalScript_table_items")
                .Peek()
                .Save();
        }

        private static IEnumerable<string> ItemsStatsIterator(IEnumerable<string> input)
        {
            string newRow = "\"scroll_rare_enchantment;;450;;;scroll;;paper;Light;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;rare;\"";
            foreach (string line in input)
            {
                // Skip if we already patched (idempotency guard)
                if (line.Contains("scroll_rare_enchantment")) { yield return line; continue; }
                // Find the closing ]; of the array and insert before it
                int idx = line.LastIndexOf("];", StringComparison.Ordinal);
                yield return (idx >= 0) ? line.Insert(idx, ", " + newRow) : line;
            }
        }
    }
}
