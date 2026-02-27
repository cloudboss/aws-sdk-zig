const CategoryFilterFunction = @import("category_filter_function.zig").CategoryFilterFunction;
const CategoryFilterType = @import("category_filter_type.zig").CategoryFilterType;
const TopicCategoryFilterConstant = @import("topic_category_filter_constant.zig").TopicCategoryFilterConstant;

/// A structure that represents a category filter.
pub const TopicCategoryFilter = struct {
    /// The category filter function. Valid values for this structure are `EXACT`
    /// and `CONTAINS`.
    category_filter_function: ?CategoryFilterFunction,

    /// The category filter type. This element is used to specify whether a filter
    /// is a simple category filter or an inverse category filter.
    category_filter_type: ?CategoryFilterType,

    /// The constant used in a category filter.
    constant: ?TopicCategoryFilterConstant,

    /// A Boolean value that indicates if the filter is inverse.
    inverse: bool = false,

    pub const json_field_names = .{
        .category_filter_function = "CategoryFilterFunction",
        .category_filter_type = "CategoryFilterType",
        .constant = "Constant",
        .inverse = "Inverse",
    };
};
