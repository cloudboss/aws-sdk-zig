/// Aac Coding Mode
pub const AacCodingMode = enum {
    ad_receiver_mix,
    coding_mode_1_0,
    coding_mode_1_1,
    coding_mode_2_0,
    coding_mode_5_1,

    pub const json_field_names = .{
        .ad_receiver_mix = "AD_RECEIVER_MIX",
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_1_1 = "CODING_MODE_1_1",
        .coding_mode_2_0 = "CODING_MODE_2_0",
        .coding_mode_5_1 = "CODING_MODE_5_1",
    };
};
