pub const ResourcesTrendsStringField = enum {
    account_id,
    region,
    resource_type,
    resource_category,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .region = "REGION",
        .resource_type = "RESOURCE_TYPE",
        .resource_category = "RESOURCE_CATEGORY",
    };
};
