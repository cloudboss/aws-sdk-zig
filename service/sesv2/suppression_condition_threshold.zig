const FeatureStatus = @import("feature_status.zig").FeatureStatus;
const SuppressionConfidenceThreshold = @import("suppression_confidence_threshold.zig").SuppressionConfidenceThreshold;

/// Contains Auto Validation settings, allowing you to suppress sending to
/// specific destination(s)
/// if they do not meet required threshold. For details on Auto Validation, see
/// [Auto
/// Validation](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/email-validation.html).
pub const SuppressionConditionThreshold = struct {
    /// Indicates whether Auto Validation is enabled for suppression. Set to
    /// `ENABLED`
    /// to enable the Auto Validation feature, or set to `DISABLED` to disable
    /// it.
    condition_threshold_enabled: FeatureStatus,

    /// The overall confidence threshold used to determine suppression decisions.
    overall_confidence_threshold: ?SuppressionConfidenceThreshold = null,

    pub const json_field_names = .{
        .condition_threshold_enabled = "ConditionThresholdEnabled",
        .overall_confidence_threshold = "OverallConfidenceThreshold",
    };
};
