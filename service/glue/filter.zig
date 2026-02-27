const FilterExpression = @import("filter_expression.zig").FilterExpression;
const FilterLogicalOperator = @import("filter_logical_operator.zig").FilterLogicalOperator;

/// Specifies a transform that splits a dataset into two, based on a filter
/// condition.
pub const Filter = struct {
    /// Specifies a filter expression.
    filters: []const FilterExpression,

    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The operator used to filter rows by comparing the key value to a specified
    /// value.
    logical_operator: FilterLogicalOperator,

    /// The name of the transform node.
    name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .inputs = "Inputs",
        .logical_operator = "LogicalOperator",
        .name = "Name",
    };
};
