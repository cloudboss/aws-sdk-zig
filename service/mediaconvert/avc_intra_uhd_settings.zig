const AvcIntraUhdQualityTuningLevel = @import("avc_intra_uhd_quality_tuning_level.zig").AvcIntraUhdQualityTuningLevel;

/// Optional when you set AVC-Intra class to Class 4K/2K. When you set AVC-Intra
/// class to a different value, this object isn't allowed.
pub const AvcIntraUhdSettings = struct {
    /// Optional. Use Quality tuning level to choose how many transcoding passes
    /// MediaConvert does with your video. When you choose Multi-pass, your video
    /// quality is better and your output bitrate is more accurate. That is, the
    /// actual bitrate of your output is closer to the target bitrate defined in the
    /// specification. When you choose Single-pass, your encoding time is faster.
    /// The default behavior is Single-pass.
    quality_tuning_level: ?AvcIntraUhdQualityTuningLevel,

    pub const json_field_names = .{
        .quality_tuning_level = "QualityTuningLevel",
    };
};
