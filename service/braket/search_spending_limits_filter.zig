const SearchSpendingLimitsFilterOperator = @import("search_spending_limits_filter_operator.zig").SearchSpendingLimitsFilterOperator;

/// Specifies filter criteria for searching spending limits. Use filters to
/// narrow down results based on specific attributes.
pub const SearchSpendingLimitsFilter = struct {
    /// The name of the field to filter on. Currently only supports `deviceArn`.
    name: []const u8,

    /// The comparison operator to use when filtering.
    operator: SearchSpendingLimitsFilterOperator,

    /// An array of values to match against the specified field.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
