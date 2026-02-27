pub const ResourcesStringField = enum {
    resource_guid,
    resource_id,
    account_id,
    region,
    resource_category,
    resource_type,
    resource_name,
    finding_type,
    product_name,

    pub const json_field_names = .{
        .resource_guid = "RESOURCE_GUID",
        .resource_id = "RESOURCE_ID",
        .account_id = "ACCOUNT_ID",
        .region = "REGION",
        .resource_category = "RESOURCE_CATEGORY",
        .resource_type = "RESOURCE_TYPE",
        .resource_name = "RESOURCE_NAME",
        .finding_type = "FINDING_TYPE",
        .product_name = "PRODUCT_NAME",
    };
};
