pub const ResourceGroupByField = enum {
    account_id,
    region,
    resource_category,
    resource_type,
    resource_name,
    finding_type,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .region = "REGION",
        .resource_category = "RESOURCE_CATEGORY",
        .resource_type = "RESOURCE_TYPE",
        .resource_name = "RESOURCE_NAME",
        .finding_type = "FINDING_TYPE",
    };
};
