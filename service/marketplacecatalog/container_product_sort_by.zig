pub const ContainerProductSortBy = enum {
    entity_id,
    last_modified_date,
    product_title,
    visibility,
    compatible_aws_services,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
        .compatible_aws_services = "CompatibleAWSServices",
    };
};
