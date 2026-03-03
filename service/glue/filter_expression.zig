const FilterOperation = @import("filter_operation.zig").FilterOperation;
const FilterValue = @import("filter_value.zig").FilterValue;

/// Specifies a filter expression.
pub const FilterExpression = struct {
    /// Whether the expression is to be negated.
    negated: ?bool = null,

    /// The type of operation to perform in the expression.
    operation: FilterOperation,

    /// A list of filter values.
    values: []const FilterValue,

    pub const json_field_names = .{
        .negated = "Negated",
        .operation = "Operation",
        .values = "Values",
    };
};
