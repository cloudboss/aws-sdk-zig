pub const FieldNameString = enum {
    resource_arn,
    role_arn,
    last_modified,

    pub const json_field_names = .{
        .resource_arn = "RESOURCE_ARN",
        .role_arn = "ROLE_ARN",
        .last_modified = "LAST_MODIFIED",
    };
};
