pub const UserIdentityType = enum {
    customer_managed,
    aws_directory_service,
    aws_iam_identity_center,

    pub const json_field_names = .{
        .customer_managed = "CUSTOMER_MANAGED",
        .aws_directory_service = "AWS_DIRECTORY_SERVICE",
        .aws_iam_identity_center = "AWS_IAM_IDENTITY_CENTER",
    };
};
