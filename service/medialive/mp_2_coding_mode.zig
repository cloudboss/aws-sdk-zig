/// Mp2 Coding Mode
pub const Mp2CodingMode = enum {
    coding_mode_1_0,
    coding_mode_2_0,

    pub const json_field_names = .{
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_2_0 = "CODING_MODE_2_0",
    };
};
