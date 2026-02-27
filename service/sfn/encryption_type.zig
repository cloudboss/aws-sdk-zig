pub const EncryptionType = enum {
    aws_owned_key,
    customer_managed_kms_key,

    pub const json_field_names = .{
        .aws_owned_key = "AWS_OWNED_KEY",
        .customer_managed_kms_key = "CUSTOMER_MANAGED_KMS_KEY",
    };
};
