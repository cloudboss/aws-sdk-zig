const SearchFilterExpression = @import("search_filter_expression.zig").SearchFilterExpression;
const LogicalOperator = @import("logical_operator.zig").LogicalOperator;

/// The search terms for a resource.
pub const SearchGroupedFilterExpressions = struct {
    /// The filters to use for the search.
    filters: []const SearchFilterExpression,

    /// The operators to include in the search.
    operator: LogicalOperator,

    pub const json_field_names = .{
        .filters = "filters",
        .operator = "operator",
    };
};
