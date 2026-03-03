const MachineLearningProductEntityIdFilter = @import("machine_learning_product_entity_id_filter.zig").MachineLearningProductEntityIdFilter;
const MachineLearningProductLastModifiedDateFilter = @import("machine_learning_product_last_modified_date_filter.zig").MachineLearningProductLastModifiedDateFilter;
const MachineLearningProductTitleFilter = @import("machine_learning_product_title_filter.zig").MachineLearningProductTitleFilter;
const MachineLearningProductVisibilityFilter = @import("machine_learning_product_visibility_filter.zig").MachineLearningProductVisibilityFilter;

/// The filters that you can use with the ListEntities operation to filter
/// machine learning products.
/// You can filter by `EntityId`, `astModifiedDate`, `ProductTitle`, and
/// `Visibility`.
pub const MachineLearningProductFilters = struct {
    /// Filter machine learning products by their entity IDs.
    entity_id: ?MachineLearningProductEntityIdFilter = null,

    /// Filter machine learning products by their last modified date.
    last_modified_date: ?MachineLearningProductLastModifiedDateFilter = null,

    /// Filter machine learning products by their product titles.
    product_title: ?MachineLearningProductTitleFilter = null,

    /// Filter machine learning products by their visibility status.
    visibility: ?MachineLearningProductVisibilityFilter = null,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
