/// Optional. Use Quality tuning level to choose how you want to trade off
/// encoding speed for output video quality. The default behavior is faster,
/// lower quality, multi-pass encoding.
pub const Vp9QualityTuningLevel = enum {
    multi_pass,
    multi_pass_hq,

    pub const json_field_names = .{
        .multi_pass = "MULTI_PASS",
        .multi_pass_hq = "MULTI_PASS_HQ",
    };
};
