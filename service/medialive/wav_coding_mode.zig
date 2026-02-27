/// Wav Coding Mode
pub const WavCodingMode = enum {
    coding_mode_1_0,
    coding_mode_2_0,
    coding_mode_4_0,
    coding_mode_8_0,

    pub const json_field_names = .{
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_2_0 = "CODING_MODE_2_0",
        .coding_mode_4_0 = "CODING_MODE_4_0",
        .coding_mode_8_0 = "CODING_MODE_8_0",
    };
};
