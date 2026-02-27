pub const WorkspaceDirectoryType = enum {
    simple_ad,
    ad_connector,
    customer_managed,
    aws_iam_identity_center,

    pub const json_field_names = .{
        .simple_ad = "SIMPLE_AD",
        .ad_connector = "AD_CONNECTOR",
        .customer_managed = "CUSTOMER_MANAGED",
        .aws_iam_identity_center = "AWS_IAM_IDENTITY_CENTER",
    };
};
