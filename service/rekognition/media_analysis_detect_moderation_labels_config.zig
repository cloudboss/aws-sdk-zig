/// Configuration for Moderation Labels Detection.
pub const MediaAnalysisDetectModerationLabelsConfig = struct {
    /// Specifies the minimum confidence level for the moderation labels to return.
    /// Amazon Rekognition
    /// doesn't return any labels with a confidence level lower than this specified
    /// value.
    min_confidence: ?f32 = null,

    /// Specifies the custom moderation model to be used during the label detection
    /// job.
    /// If not provided the pre-trained model is used.
    project_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .min_confidence = "MinConfidence",
        .project_version = "ProjectVersion",
    };
};
