const AudioQualityMetricsInfo = @import("audio_quality_metrics_info.zig").AudioQualityMetricsInfo;

/// Information about the quality of the Agent's media connection
pub const AgentQualityMetrics = struct {
    /// Information about the audio quality of the Agent
    audio: ?AudioQualityMetricsInfo,

    pub const json_field_names = .{
        .audio = "Audio",
    };
};
