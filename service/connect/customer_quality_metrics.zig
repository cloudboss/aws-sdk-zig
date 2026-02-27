const AudioQualityMetricsInfo = @import("audio_quality_metrics_info.zig").AudioQualityMetricsInfo;

/// Information about the quality of the Customer's media connection
pub const CustomerQualityMetrics = struct {
    /// Information about the audio quality of the Customer
    audio: ?AudioQualityMetricsInfo,

    pub const json_field_names = .{
        .audio = "Audio",
    };
};
