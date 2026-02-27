const CostCategoryValues = @import("cost_category_values.zig").CostCategoryValues;
const DimensionValues = @import("dimension_values.zig").DimensionValues;
const TagValues = @import("tag_values.zig").TagValues;
const TimeRange = @import("time_range.zig").TimeRange;

/// See
/// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_billing_Expression.html). Billing view only supports `LINKED_ACCOUNT`, `Tags`, and `CostCategories`.
pub const Expression = struct {
    /// The filter that's based on `CostCategory` values.
    cost_categories: ?CostCategoryValues,

    /// The specific `Dimension` to use for `Expression`.
    dimensions: ?DimensionValues,

    /// The specific `Tag` to use for `Expression`.
    tags: ?TagValues,

    /// Specifies a time range filter for the billing view data.
    time_range: ?TimeRange,

    pub const json_field_names = .{
        .cost_categories = "costCategories",
        .dimensions = "dimensions",
        .tags = "tags",
        .time_range = "timeRange",
    };
};
