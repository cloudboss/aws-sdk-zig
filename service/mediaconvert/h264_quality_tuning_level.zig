/// The Quality tuning level you choose represents a trade-off between the
/// encoding speed of your job and the output video quality. For the fastest
/// encoding speed at the cost of video quality: Choose Single pass. For a good
/// balance between encoding speed and video quality: Leave blank or keep the
/// default value Single pass HQ. For the best video quality, at the cost of
/// encoding speed: Choose Multi pass HQ. MediaConvert performs an analysis pass
/// on your input followed by an encoding pass. Outputs that use this feature
/// incur pro-tier pricing.
pub const H264QualityTuningLevel = enum {
    single_pass,
    single_pass_hq,
    multi_pass_hq,

    pub const json_field_names = .{
        .single_pass = "SINGLE_PASS",
        .single_pass_hq = "SINGLE_PASS_HQ",
        .multi_pass_hq = "MULTI_PASS_HQ",
    };
};
