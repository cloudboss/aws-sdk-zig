const CostCategoryValues = @import("cost_category_values.zig").CostCategoryValues;
const DimensionValues = @import("dimension_values.zig").DimensionValues;
const TagValues = @import("tag_values.zig").TagValues;

/// Defines complex filtering conditions using logical operators (`AND`, `OR`,
/// `NOT`) and various filter types.
pub const Expression = struct {
    /// A list of expressions to combine with AND logic.
    @"and": ?[]const Expression = null,

    /// The cost category values to include in the filter expression.
    cost_categories: ?CostCategoryValues = null,

    /// The dimension values to include in the filter expression.
    dimensions: ?DimensionValues = null,

    /// An expression to negate with NOT logic.
    not: ?*Expression = null,

    /// A list of expressions to combine with OR logic.
    @"or": ?[]const Expression = null,

    /// The tag values to include in the filter expression.
    tags: ?TagValues = null,

    pub const json_field_names = .{
        .@"and" = "and",
        .cost_categories = "costCategories",
        .dimensions = "dimensions",
        .not = "not",
        .@"or" = "or",
        .tags = "tags",
    };
};
