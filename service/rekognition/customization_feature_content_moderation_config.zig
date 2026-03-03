/// Configuration options for Content Moderation training.
pub const CustomizationFeatureContentModerationConfig = struct {
    /// The confidence level you plan to use to identify if unsafe content is
    /// present during inference.
    confidence_threshold: ?f32 = null,

    pub const json_field_names = .{
        .confidence_threshold = "ConfidenceThreshold",
    };
};
