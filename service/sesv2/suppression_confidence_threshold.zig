const SuppressionConfidenceVerdictThreshold = @import("suppression_confidence_verdict_threshold.zig").SuppressionConfidenceVerdictThreshold;

/// Contains the confidence threshold settings for Auto Validation.
pub const SuppressionConfidenceThreshold = struct {
    /// The confidence level threshold for suppression decisions.
    confidence_verdict_threshold: SuppressionConfidenceVerdictThreshold,

    pub const json_field_names = .{
        .confidence_verdict_threshold = "ConfidenceVerdictThreshold",
    };
};
