const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Information needed to compare two values with a comparison operator.
pub const SimpleRuleEvaluation = struct {
    /// The value of the input property, on the left side of the comparison
    /// operator.
    input_property_value: ?[]const u8 = null,

    /// The comparison operator.
    operator: ?ComparisonOperator = null,

    /// The threshold value, on the right side of the comparison operator.
    threshold_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .input_property_value = "inputPropertyValue",
        .operator = "operator",
        .threshold_value = "thresholdValue",
    };
};
