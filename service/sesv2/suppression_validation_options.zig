const SuppressionConditionThreshold = @import("suppression_condition_threshold.zig").SuppressionConditionThreshold;

/// Contains validation options for email address suppression.
pub const SuppressionValidationOptions = struct {
    /// Specifies the condition threshold settings for suppression validation.
    condition_threshold: SuppressionConditionThreshold,

    pub const json_field_names = .{
        .condition_threshold = "ConditionThreshold",
    };
};
