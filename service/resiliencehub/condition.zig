const ConditionOperatorType = @import("condition_operator_type.zig").ConditionOperatorType;

/// Indicates the condition based on which you want to filter the metrics.
pub const Condition = struct {
    /// Indicates the field in the metric.
    field: []const u8,

    /// Indicates the type of operator or comparison to be used when evaluating a
    /// condition against the specified field.
    operator: ConditionOperatorType,

    /// Indicates the value or data against which a condition is evaluated.
    value: ?[]const u8,

    pub const json_field_names = .{
        .field = "field",
        .operator = "operator",
        .value = "value",
    };
};
