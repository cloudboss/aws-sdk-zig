pub const EncryptionType = enum {
    aws_managed_key,
    customer_managed_key,

    pub const json_field_names = .{
        .aws_managed_key = "AWS_MANAGED_KEY",
        .customer_managed_key = "CUSTOMER_MANAGED_KEY",
    };
};
