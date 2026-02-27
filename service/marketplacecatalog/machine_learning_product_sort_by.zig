/// The fields that you can sort machine learning products by.
pub const MachineLearningProductSortBy = enum {
    entity_id,
    last_modified_date,
    product_title,
    visibility,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };
};
