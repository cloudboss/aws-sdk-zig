pub const ScopeName = enum {
    organization,
    account_id,
    resource_arn,

    pub const json_field_names = .{
        .organization = "ORGANIZATION",
        .account_id = "ACCOUNT_ID",
        .resource_arn = "RESOURCE_ARN",
    };
};
