const CostCategoryValues = @import("cost_category_values.zig").CostCategoryValues;
const ExpressionDimensionValues = @import("expression_dimension_values.zig").ExpressionDimensionValues;
const TagValues = @import("tag_values.zig").TagValues;

/// Use Expression to filter in various Budgets APIs.
pub const Expression = struct {
    /// Return results that match both Dimension objects.
    @"and": ?[]const Expression,

    /// The filter that's based on CostCategoryValues.
    cost_categories: ?CostCategoryValues,

    /// The specific Dimension to use for Expression.
    dimensions: ?ExpressionDimensionValues,

    /// Return results that don't match a Dimension object.
    not: ?*Expression = null,

    /// Return results that match either Dimension object.
    @"or": ?[]const Expression,

    /// The specific Tag to use for Expression.
    tags: ?TagValues,

    pub const json_field_names = .{
        .@"and" = "And",
        .cost_categories = "CostCategories",
        .dimensions = "Dimensions",
        .not = "Not",
        .@"or" = "Or",
        .tags = "Tags",
    };
};
