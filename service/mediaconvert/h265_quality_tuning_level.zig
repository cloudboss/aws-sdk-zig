/// Optional. Use Quality tuning level to choose how you want to trade off
/// encoding speed for output video quality. The default behavior is faster,
/// lower quality, single-pass encoding.
pub const H265QualityTuningLevel = enum {
    single_pass,
    single_pass_hq,
    multi_pass_hq,

    pub const json_field_names = .{
        .single_pass = "SINGLE_PASS",
        .single_pass_hq = "SINGLE_PASS_HQ",
        .multi_pass_hq = "MULTI_PASS_HQ",
    };
};
