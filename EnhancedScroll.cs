using System;
using System.Collections.Generic;
using ModShardLauncher;
using ModShardLauncher.Mods;
using UndertaleModLib.Models;

namespace EnhancedScrollsMod
{
    public class EnhancedScrolls : Mod
    {
        public override string Author => "YourName";
        public override string Name => "Enhanced Scrolls Mod";
        public override string Description => "Clean, human-readable scroll mod.";
        public override string Version => "2.0.0";
        public override string TargetVersion => "0.9.4.20";

        public override void PatchMod()
        {
            // --- LOAD GLOBAL SCRIPTS FROM FILES SAFELY ---
            Msl.AddFunction(ModFiles.GetCode("Codes/apply_hexing_curse.gml"), "apply_hexing_curse");

            // --- ALIAS REDIRECT BRIDGES ---
            // Registers blank execution blocks under the old names so unedited base game files don't crash!
            Msl.AddFunction("return 0;", "scr_cursed_scroll_refresh_curse_name");
            Msl.AddFunction("return 0;", "scr_cursed_scroll_clear_enchantments");
            Msl.AddFunction("return 0;", "scr_cursed_scroll_random_enchant");

            // 1. DYNAMIC ASSET INITIALIZATION
            UndertaleGameObject scrollBlessed = Msl.AddObject("o_inv_scroll_blessed", "s_inv_scroll", "o_inv_scroll_parent", true);
            UndertaleGameObject scrollEpic    = Msl.AddObject("o_inv_scroll_epic_enchantment", "s_inv_scroll", "o_inv_scroll_parent", true);
            UndertaleGameObject scrollLegend  = Msl.AddObject("o_inv_scroll_legendary_enchantment", "s_inv_scroll", "o_inv_scroll_parent", true);
            UndertaleGameObject scrollRare    = Msl.AddObject("o_inv_scroll_rare_enchantment", "s_inv_scroll", "o_inv_scroll_parent", true);
            UndertaleGameObject scrollHexing  = Msl.AddObject("o_inv_scroll_cursed_hexing", "s_inv_scroll", "o_inv_scroll_parent", true);

            // 2. FLAT GML CODE ATTACHMENTS
            Msl.AddNewEvent(scrollBlessed, ModFiles.GetCode("Codes/blessed_scroll_create.gml"), (EventType)0, 0u);
            Msl.AddNewEvent(scrollBlessed, ModFiles.GetCode("Codes/blessed_scroll_use.gml"), (EventType)7, 0u);
            
            Msl.AddNewEvent(scrollEpic, ModFiles.GetCode("Codes/epic_scroll_create.gml"), (EventType)0, 0u);
            Msl.AddNewEvent(scrollEpic, ModFiles.GetCode("Codes/epic_scroll_use.gml"), (EventType)7, 0u);

            Msl.AddNewEvent(scrollLegend, ModFiles.GetCode("Codes/legendary_scroll_create.gml"), (EventType)0, 0u);
            Msl.AddNewEvent(scrollLegend, ModFiles.GetCode("Codes/legendary_scroll_use.gml"), (EventType)7, 0u);

            Msl.AddNewEvent(scrollRare, ModFiles.GetCode("Codes/rare_scroll_create.gml"), (EventType)0, 0u);
            Msl.AddNewEvent(scrollRare, ModFiles.GetCode("Codes/rare_scroll_use.gml"), (EventType)7, 0u);

            Msl.AddNewEvent(scrollHexing, ModFiles.GetCode("Codes/hexing_scroll_create.gml"), (EventType)0, 0u);
            Msl.AddNewEvent(scrollHexing, ModFiles.GetCode("Codes/hexing_scroll_use.gml"), (EventType)7, 0u);

            // 3. INTERFACE OVERLAY PATCH
            Msl.Save(Msl.Apply(
                Msl.LoadGML("gml_Object_o_inv_slot_Draw_0"), 
                (Func<IEnumerable<string>, IEnumerable<string>>)InterfaceFilterIterator
            ));

            // 4. LOOT DROP INJECTION PATCH
            Msl.Save(Msl.Apply(
                Msl.LoadGML("gml_GlobalScript_scr_get_scroll"), 
                (Func<IEnumerable<string>, IEnumerable<string>>)ScrollLootIterator
            ));
        }

        private static IEnumerable<string> InterfaceFilterIterator(IEnumerable<string> input)
        {
            foreach (string line in input) yield return line;
            yield return "event_inherited();";
            yield return "with (o_inv_slot) {";
            yield return "    var _quality = ds_map_find_value_ext(data, \"quality\", -4);";
            yield return "    var _metatype = ds_map_find_value_ext(data, \"Metatype\", \"\");";
            yield return "    if (owner.object_index != o_trade_inventory && (_metatype == \"Weapon\" || _metatype == \"Armor\") && ds_map_find_value_ext(data, \"identified\", false) && (!(ds_map_find_value_ext(data, \"is_cursed\", true))) && _quality != (6 << 0)) {";
            yield return "        image_alpha = 1;";
            yield return "    } else {";
            yield return "        image_alpha = 0.25;";
            yield return "    }";
            yield return "    can_pick = false;";
            yield return "}";
        }

        private static IEnumerable<string> ScrollLootIterator(IEnumerable<string> input)
        {
            foreach (string line in input)
            {
                yield return line;
                if (line.Contains("var _scroll = choose("))
                {
                    yield return "    _scroll = choose(o_inv_scroll_blessed, o_inv_scroll_legendary_enchantment, o_inv_scroll_epic_enchantment, o_inv_scroll_rare_enchantment, o_inv_scroll_cursed_hexing);";
                }
            }
        }
    }
}
