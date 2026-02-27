pub const KeyType = enum {
    aws_owned_key,
    customer_managed_key,

    pub const json_field_names = .{
        .aws_owned_key = "AWS_OWNED_KEY",
        .customer_managed_key = "CUSTOMER_MANAGED_KEY",
    };
};
