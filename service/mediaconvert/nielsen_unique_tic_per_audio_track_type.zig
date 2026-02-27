/// To create assets that have the same TIC values in each audio track, keep the
/// default value Share TICs. To create assets that have unique TIC values for
/// each audio track, choose Use unique TICs.
pub const NielsenUniqueTicPerAudioTrackType = enum {
    reserve_unique_tics_per_track,
    same_tics_per_track,

    pub const json_field_names = .{
        .reserve_unique_tics_per_track = "RESERVE_UNIQUE_TICS_PER_TRACK",
        .same_tics_per_track = "SAME_TICS_PER_TRACK",
    };
};
