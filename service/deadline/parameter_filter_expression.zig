const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// The details of a filtered search for parameters.
pub const ParameterFilterExpression = struct {
    /// The name of the parameter to filter on.
    name: []const u8,

    /// The type of comparison to use to filter results.
    operator: ComparisonOperator,

    /// The parameter's value.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .value = "value",
    };
};
