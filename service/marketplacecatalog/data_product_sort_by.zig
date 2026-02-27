pub const DataProductSortBy = enum {
    entity_id,
    product_title,
    visibility,
    last_modified_date,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
        .last_modified_date = "LastModifiedDate",
    };
};
