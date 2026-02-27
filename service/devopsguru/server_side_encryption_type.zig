pub const ServerSideEncryptionType = enum {
    customer_managed_key,
    aws_owned_kms_key,

    pub const json_field_names = .{
        .customer_managed_key = "CUSTOMER_MANAGED_KEY",
        .aws_owned_kms_key = "AWS_OWNED_KMS_KEY",
    };
};
