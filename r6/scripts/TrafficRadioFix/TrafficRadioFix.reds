// ======================================================================================
// Mod Name: Traffic Radio Fix
// Author: Spuddeh
// Description: Gives every traffic car a traffic radio, so no passing car plays as if inside the player's own.
// Mod Version: 0.1.0
// Credits: TweakXL by psiberx.
// ======================================================================================
//
// A traffic car uses the sound set its vehicle record names in traffic_audio_resource. Every sound set
// built for the player's own car carries a player radio receiver (radio_car_*_player), which plays as
// if inside the player's car at any distance. This runs after every mod's tweaks have loaded and moves
// any record pointing at such a set to the same model's traffic set, so a vanilla record, a record a
// mod builds on one with $base, and a mod's own record are all caught without naming any of them.
//
// The table is every vehicle sound set in the game's audio metadata with a player receiver and its
// radio switched on, paired with the set named <model>_traffic, falling back to the nearest shorter
// name that has one. The two Larimore sets have no traffic set; only the Mackinaw BMF uses them, so
// they map to the Mackinaw's.

module TrafficRadioFix

@if(ModuleExists("RedLogger"))
import RedLogger.*

// RedLogger is optional: with it, each run writes r6\logs\mods\TrafficRadioFix__<date>.log; without it, nothing.
@if(ModuleExists("RedLogger"))
func TrafficRadioFixLog(line: String) -> Void {
    RedLog.Append("TrafficRadioFix", line);
}

@if(!ModuleExists("RedLogger"))
func TrafficRadioFixLog(line: String) -> Void {}

public class TrafficRadioFixTweak extends ScriptableTweak {
    protected cb func OnApply() -> Void {
        let table = TrafficRadioFixTweak.Table();
        let size = ArraySize(table);
        let scanned = 0;
        let swapped = 0;
        for record in TweakDBInterface.GetRecords(n"Vehicle") {
            let vehicle = record as Vehicle_Record;
            if IsDefined(vehicle) {
                scanned += 1;
                let current = vehicle.Traffic_audio_resource();
                let i = 0;
                while i < size {
                    if Equals(table[i], current) {
                        let flat = vehicle.GetID();
                        TDBID.Append(flat, t".traffic_audio_resource");
                        TweakDBManager.SetFlat(flat, ToVariant(table[i + 1]));
                        TweakDBManager.UpdateRecord(vehicle.GetID());
                        swapped += 1;
                        TrafficRadioFixLog(TDBID.ToStringDEBUG(vehicle.GetID()) + ": " + current + " -> " + table[i + 1]);
                        i = size;
                    } else {
                        i += 2;
                    }
                }
            }
        }
        TrafficRadioFixLog("checked " + IntToString(scanned) + " vehicle records against " + IntToString(size / 2)
            + " player-radio sound sets, swapped " + IntToString(swapped));
        // The static patch's records, as the script found them: on their traffic set if the YAML applied.
        for name in TrafficRadioFixTweak.StaticRecords() {
            let vehicle = TweakDBInterface.GetVehicleRecord(TDBID.Create(name));
            if IsDefined(vehicle) {
                TrafficRadioFixLog(name + ": " + vehicle.Traffic_audio_resource());
            }
        }
    }

    // The records TrafficRadioFix.yaml sets, so a run shows whether the static patch applied.
    private static func StaticRecords() -> array<String> {
        return [
            "Vehicle.v_sport2_mizutani_shion_sport",
            "Vehicle.v_sport2_mizutani_shion_tdr",
            "Vehicle.v_utility4_thorton_mackinaw_bmf"
        ];
    }

    // Pairs: a sound set with a player radio, then the traffic set that replaces it.
    private static func Table() -> array<String> {
        return [
        "v_car_archer_hella", "v_car_archer_hella_traffic",
        "v_car_archer_hella_jacky", "v_car_archer_hella_traffic",
        "v_car_archer_hella_police", "v_car_archer_hella_police_traffic",
        "v_car_archer_hella_poor", "v_car_archer_hella_traffic",
        "v_car_archer_hella_scavenger", "v_car_archer_hella_traffic",
        "v_car_archer_quartz", "v_car_archer_quartz_traffic",
        "v_car_archer_quartz_bandit", "v_car_archer_quartz_bandit_traffic",
        "v_car_archer_quartz_gt", "v_car_archer_quartz_traffic",
        "v_car_archer_quartz_nomad", "v_car_archer_quartz_nomad_traffic",
        "v_car_chevalier_centurion", "v_car_chevalier_centurion_traffic",
        "v_car_chevalier_emperor", "v_car_chevalier_emperor_traffic",
        "v_car_chevalier_emperor_police", "v_car_chevalier_emperor_police_traffic",
        "v_car_chevalier_thrax", "v_car_chevalier_thrax_traffic",
        "v_car_chevalier_thrax_ncu", "v_car_chevalier_thrax_ncu_traffic",
        "v_car_chevalier_thrax_scavenger", "v_car_chevalier_thrax_traffic",
        "v_car_herrera_outlaw", "v_car_herrera_outlaw_traffic",
        "v_car_herrera_riptide", "v_car_herrera_riptide_traffic",
        "v_car_kaukaz_bratsk", "v_car_kaukaz_bratsk_traffic",
        "v_car_kaukaz_bratsk_missle", "v_car_kaukaz_bratsk_traffic",
        "v_car_kaukaz_zeya", "v_car_kaukaz_zeya_traffic",
        "v_car_kaukaz_zeya_barrels", "v_car_kaukaz_zeya_traffic",
        "v_car_mahir_eraz", "v_car_mahir_eraz_traffic",
        "v_car_mahir_supron", "v_car_mahir_supron_traffic",
        "v_car_mahir_supron_gt", "v_car_mahir_supron_traffic",
        "v_car_mahir_supron_kurtz", "v_car_mahir_supron_kurtz_traffic",
        "v_car_makigai_maimai", "v_car_makigai_maimai_traffic",
        "v_car_makigai_maimai_poor", "v_car_makigai_maimai_traffic",
        "v_car_makigai_tanishi", "v_car_makigai_tanishi_traffic",
        "v_car_militech_atilla", "v_car_militech_atilla_traffic",
        "v_car_militech_hellhound", "v_car_militech_hellhound_traffic",
        "v_car_militech_hellhound_police", "v_car_militech_hellhound_police_traffic",
        "v_car_mizutani_hozuki", "v_car_mizutani_hozuki_traffic",
        "v_car_mizutani_hozuki_sport", "v_car_mizutani_hozuki_traffic",
        "v_car_mizutani_hozuki_sti", "v_car_mizutani_hozuki_traffic",
        "v_car_mizutani_shion", "v_car_mizutani_shion_traffic",
        "v_car_mizutani_shion_nomad", "v_car_mizutani_shion_nomad_traffic",
        "v_car_mizutani_shion_sport", "v_car_mizutani_shion_traffic",
        "v_car_mizutani_shion_targa", "v_car_mizutani_shion_targa_traffic",
        "v_car_mizutani_shion_tygerclaw", "v_car_mizutani_shion_tygerclaw_traffic",
        "v_car_porsche_911_turbo", "v_car_porsche_911_turbo_traffic",
        "v_car_porsche_911_turbo_targa", "v_car_porsche_911_turbo_traffic",
        "v_car_quadra_sport_r7", "v_car_quadra_sport_r7_traffic",
        "v_car_quadra_sport_r7_gt", "v_car_quadra_sport_r7_traffic",
        "v_car_quadra_sport_r7_poor", "v_car_quadra_sport_r7_traffic",
        "v_car_quadra_sport_r7_rocket", "v_car_quadra_sport_r7_traffic",
        "v_car_quadra_turbo_r", "v_car_quadra_turbo_r_traffic",
        "v_car_quadra_turbo_r_vtek", "v_car_quadra_turbo_r_traffic",
        "v_car_quadra_type_66", "v_car_quadra_type_66_traffic",
        "v_car_quadra_type_66_avenger", "v_car_quadra_type_66_avenger_traffic",
        "v_car_quadra_type_66_ncu", "v_car_quadra_type_66_ncu_traffic",
        "v_car_quadra_type_66_nomad", "v_car_quadra_type_66_nomad_traffic",
        "v_car_quadra_type_66_rogue", "v_car_quadra_type_66_rogue_traffic",
        "v_car_rayfield_aerondight", "v_car_rayfield_aerondight_traffic",
        "v_car_rayfield_caliburn", "v_car_rayfield_caliburn_traffic",
        "v_car_thorton_colby", "v_car_thorton_colby_traffic",
        "v_car_thorton_colby_aldecaldo", "v_car_thorton_colby_aldecaldo_traffic",
        "v_car_thorton_colby_gt", "v_car_thorton_colby_traffic",
        "v_car_thorton_colby_kurtz", "v_car_thorton_colby_kurtz_traffic",
        "v_car_thorton_colby_nomad", "v_car_thorton_colby_nomad_traffic",
        "v_car_thorton_colby_pickup", "v_car_thorton_colby_pickup_traffic",
        "v_car_thorton_colby_scavenger", "v_car_thorton_colby_traffic",
        "v_car_thorton_galena", "v_car_thorton_galena_traffic",
        "v_car_thorton_galena_gt", "v_car_thorton_galena_traffic",
        "v_car_thorton_galena_ncu", "v_car_thorton_galena_ncu_traffic",
        "v_car_thorton_galena_nomad", "v_car_thorton_galena_nomad_traffic",
        "v_car_thorton_galena_poor", "v_car_thorton_galena_traffic",
        "v_car_thorton_galena_q204", "v_car_thorton_galena_q204_traffic",
        "v_car_thorton_galena_red", "v_car_thorton_galena_red_traffic",
        "v_car_thorton_galena_sq011", "v_car_thorton_galena_traffic",
        "v_car_thorton_larimore", "v_car_thorton_mackinaw_traffic",
        "v_car_thorton_larimore_traffic", "v_car_thorton_mackinaw_traffic",
        "v_car_thorton_mackinaw", "v_car_thorton_mackinaw_traffic",
        "v_car_thorton_mackinaw_nomad", "v_car_thorton_mackinaw_nomad_traffic",
        "v_car_thorton_mackinaw_nomad_alt", "v_car_thorton_mackinaw_nomad_alt_traffic",
        "v_car_thorton_merrimac", "v_car_thorton_merrimac_traffic",
        "v_car_thorton_merrimac_maxtac", "v_car_thorton_merrimac_maxtac_traffic",
        "v_car_thorton_merrimac_police", "v_car_thorton_merrimac_police_traffic",
        "v_car_villefort_alvarado", "v_car_villefort_alvarado_traffic",
        "v_car_villefort_alvarado_cabrio", "v_car_villefort_alvarado_cabrio_traffic",
        "v_car_villefort_alvarado_wagon", "v_car_villefort_alvarado_wagon_traffic",
        "v_car_villefort_columbus", "v_car_villefort_columbus_traffic",
        "v_car_villefort_columbus_q105", "v_car_villefort_columbus_traffic",
        "v_car_villefort_columbus_q105_traffic", "v_car_villefort_columbus_traffic",
        "v_car_villefort_columbus_scavengers", "v_car_villefort_columbus_traffic",
        "v_car_villefort_cortes", "v_car_villefort_cortes_traffic",
        "v_car_villefort_cortes_delamain", "v_car_villefort_cortes_delamain_traffic",
        "v_car_villefort_cortes_police", "v_car_villefort_cortes_police_traffic",
        "v_car_villefort_cortes_poor", "v_car_villefort_cortes_traffic",
        "v_car_villefort_deleon", "v_car_villefort_deleon_traffic",
        "v_car_villefort_deleon_poor", "v_car_villefort_deleon_traffic"
        ];
    }
}
