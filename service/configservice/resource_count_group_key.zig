pub const ResourceCountGroupKey = enum {
    resource_type,
    account_id,
    aws_region,

    pub const json_field_names = .{
        .resource_type = "RESOURCE_TYPE",
        .account_id = "ACCOUNT_ID",
        .aws_region = "AWS_REGION",
    };
};
