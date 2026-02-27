const FilterExpression = @import("filter_expression.zig").FilterExpression;
const FilterLogicalOperator = @import("filter_logical_operator.zig").FilterLogicalOperator;

/// Specifies a group of filters with a logical operator that determines how the
/// filters are combined to evaluate routing conditions.
pub const GroupFilters = struct {
    /// A list of filter expressions that define the conditions for this group.
    filters: []const FilterExpression,

    /// The name of the filter group.
    group_name: []const u8,

    /// The logical operator used to combine the filters in this group. Determines
    /// whether all filters must match (AND) or any filter can match (OR).
    logical_operator: FilterLogicalOperator,

    pub const json_field_names = .{
        .filters = "Filters",
        .group_name = "GroupName",
        .logical_operator = "LogicalOperator",
    };
};
