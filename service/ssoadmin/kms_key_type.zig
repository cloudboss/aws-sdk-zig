pub const KmsKeyType = enum {
    aws_owned_kms_key,
    customer_managed_key,

    pub const json_field_names = .{
        .aws_owned_kms_key = "AWS_OWNED_KMS_KEY",
        .customer_managed_key = "CUSTOMER_MANAGED_KEY",
    };
};
