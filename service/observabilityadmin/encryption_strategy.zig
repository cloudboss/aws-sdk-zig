pub const EncryptionStrategy = enum {
    customer_managed,
    aws_owned,

    pub const json_field_names = .{
        .customer_managed = "CUSTOMER_MANAGED",
        .aws_owned = "AWS_OWNED",
    };
};
