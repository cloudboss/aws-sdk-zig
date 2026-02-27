pub const KeyType = enum {
    aws_owned_cmk,
    customer_managed_cmk,

    pub const json_field_names = .{
        .aws_owned_cmk = "AWS_OWNED_CMK",
        .customer_managed_cmk = "CUSTOMER_MANAGED_CMK",
    };
};
