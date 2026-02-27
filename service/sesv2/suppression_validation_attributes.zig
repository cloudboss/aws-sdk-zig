const SuppressionConditionThreshold = @import("suppression_condition_threshold.zig").SuppressionConditionThreshold;

/// Structure containing validation attributes used for suppressing sending to
/// specific destination on account level.
pub const SuppressionValidationAttributes = struct {
    /// Specifies the condition threshold settings for account-level suppression.
    condition_threshold: SuppressionConditionThreshold,

    pub const json_field_names = .{
        .condition_threshold = "ConditionThreshold",
    };
};
