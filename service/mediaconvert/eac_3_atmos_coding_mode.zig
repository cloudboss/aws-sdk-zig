/// The coding mode for Dolby Digital Plus JOC (Atmos).
pub const Eac3AtmosCodingMode = enum {
    coding_mode_auto,
    coding_mode_5_1_4,
    coding_mode_7_1_4,
    coding_mode_9_1_6,

    pub const json_field_names = .{
        .coding_mode_auto = "CODING_MODE_AUTO",
        .coding_mode_5_1_4 = "CODING_MODE_5_1_4",
        .coding_mode_7_1_4 = "CODING_MODE_7_1_4",
        .coding_mode_9_1_6 = "CODING_MODE_9_1_6",
    };
};
