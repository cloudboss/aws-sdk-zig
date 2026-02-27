pub const SaaSProductSortBy = enum {
    entity_id,
    product_title,
    visibility,
    last_modified_date,
    delivery_option_types,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
        .last_modified_date = "LastModifiedDate",
        .delivery_option_types = "DeliveryOptionTypes",
    };
};
