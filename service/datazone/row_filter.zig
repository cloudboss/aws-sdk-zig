const RowFilterExpression = @import("row_filter_expression.zig").RowFilterExpression;

/// The row filter.
pub const RowFilter = union(enum) {
    /// The 'and' clause of the row filter.
    @"and": ?[]const RowFilter,
    /// The expression of the row filter.
    expression: ?RowFilterExpression,
    /// The 'or' clause of the row filter.
    @"or": ?[]const RowFilter,

    pub const json_field_names = .{
        .@"and" = "and",
        .expression = "expression",
        .@"or" = "or",
    };
};
