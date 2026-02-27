const MachineLearningProductSortBy = @import("machine_learning_product_sort_by.zig").MachineLearningProductSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The sort options for machine learning products.
pub const MachineLearningProductSort = struct {
    /// The field to sort by. Valid values: `EntityId`, `LastModifiedDate`,
    /// `ProductTitle`, and `Visibility`.
    sort_by: ?MachineLearningProductSortBy,

    /// The sort order. Valid values are `ASC` (ascending) and `DESC` (descending).
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
