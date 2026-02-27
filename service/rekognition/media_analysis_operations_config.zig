const MediaAnalysisDetectModerationLabelsConfig = @import("media_analysis_detect_moderation_labels_config.zig").MediaAnalysisDetectModerationLabelsConfig;

/// Configuration options for a media analysis job. Configuration is
/// operation-specific.
pub const MediaAnalysisOperationsConfig = struct {
    /// Contains configuration options for a DetectModerationLabels job.
    detect_moderation_labels: ?MediaAnalysisDetectModerationLabelsConfig,

    pub const json_field_names = .{
        .detect_moderation_labels = "DetectModerationLabels",
    };
};
