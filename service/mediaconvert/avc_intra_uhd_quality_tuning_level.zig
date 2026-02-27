/// Optional. Use Quality tuning level to choose how many transcoding passes
/// MediaConvert does with your video. When you choose Multi-pass, your video
/// quality is better and your output bitrate is more accurate. That is, the
/// actual bitrate of your output is closer to the target bitrate defined in the
/// specification. When you choose Single-pass, your encoding time is faster.
/// The default behavior is Single-pass.
pub const AvcIntraUhdQualityTuningLevel = enum {
    single_pass,
    multi_pass,

    pub const json_field_names = .{
        .single_pass = "SINGLE_PASS",
        .multi_pass = "MULTI_PASS",
    };
};
