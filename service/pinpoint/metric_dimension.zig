/// Specifies metric-based criteria for including or excluding endpoints from a
/// segment. These criteria derive from custom metrics that you define for
/// endpoints.
pub const MetricDimension = struct {
    /// The operator to use when comparing metric values. Valid values are:
    /// GREATER_THAN, LESS_THAN, GREATER_THAN_OR_EQUAL, LESS_THAN_OR_EQUAL, and
    /// EQUAL.
    comparison_operator: []const u8,

    /// The value to compare.
    value: f64,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .value = "Value",
    };
};
