/// Dolby Digital Plus coding mode. Determines number of channels.
pub const Eac3CodingMode = enum {
    coding_mode_1_0,
    coding_mode_2_0,
    coding_mode_3_2,
    coding_mode_auto,

    pub const json_field_names = .{
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_2_0 = "CODING_MODE_2_0",
        .coding_mode_3_2 = "CODING_MODE_3_2",
        .coding_mode_auto = "CODING_MODE_AUTO",
    };
};
