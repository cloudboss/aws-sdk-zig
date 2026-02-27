pub const EncryptionType = enum {
    customer_kms,
    aws_owned_kms_key,

    pub const json_field_names = .{
        .customer_kms = "CUSTOMER_KMS",
        .aws_owned_kms_key = "AWS_OWNED_KMS_KEY",
    };
};
