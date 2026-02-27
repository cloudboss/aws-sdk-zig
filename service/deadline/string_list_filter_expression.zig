const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// Searches for a particular list of strings.
pub const StringListFilterExpression = struct {
    /// The field name to search.
    name: []const u8,

    /// The type of comparison to use for this search.
    operator: ComparisonOperator,

    /// The list of string values to search for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
