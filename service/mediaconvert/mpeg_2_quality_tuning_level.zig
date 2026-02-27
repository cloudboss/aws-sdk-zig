/// Optional. Use Quality tuning level to choose how you want to trade off
/// encoding speed for output video quality. The default behavior is faster,
/// lower quality, single-pass encoding.
pub const Mpeg2QualityTuningLevel = enum {
    single_pass,
    multi_pass,

    pub const json_field_names = .{
        .single_pass = "SINGLE_PASS",
        .multi_pass = "MULTI_PASS",
    };
};
