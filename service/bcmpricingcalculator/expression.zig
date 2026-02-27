const ExpressionFilter = @import("expression_filter.zig").ExpressionFilter;

/// Represents a complex filtering expression for cost and usage data.
pub const Expression = struct {
    /// A list of expressions to be combined with AND logic.
    @"and": ?[]const Expression,

    /// Filters based on cost categories.
    cost_categories: ?ExpressionFilter,

    /// Filters based on dimensions (e.g., service, operation).
    dimensions: ?ExpressionFilter,

    /// An expression to be negated.
    not: ?*Expression = null,

    /// A list of expressions to be combined with OR logic.
    @"or": ?[]const Expression,

    /// Filters based on resource tags.
    tags: ?ExpressionFilter,

    pub const json_field_names = .{
        .@"and" = "and",
        .cost_categories = "costCategories",
        .dimensions = "dimensions",
        .not = "not",
        .@"or" = "or",
        .tags = "tags",
    };
};
