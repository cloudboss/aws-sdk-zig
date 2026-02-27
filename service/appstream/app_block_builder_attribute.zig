pub const AppBlockBuilderAttribute = enum {
    iam_role_arn,
    access_endpoints,
    vpc_configuration_security_group_ids,

    pub const json_field_names = .{
        .iam_role_arn = "IAM_ROLE_ARN",
        .access_endpoints = "ACCESS_ENDPOINTS",
        .vpc_configuration_security_group_ids = "VPC_CONFIGURATION_SECURITY_GROUP_IDS",
    };
};
