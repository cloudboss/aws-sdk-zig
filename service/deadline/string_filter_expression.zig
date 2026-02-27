const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Searches for a particular string.
pub const StringFilterExpression = struct {
    /// The field name to search.
    name: []const u8,

    /// The type of comparison to use for this search.
    operator: ComparisonOperator,

    /// The string to search for.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .value = "value",
    };
};
