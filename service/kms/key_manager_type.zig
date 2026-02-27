pub const KeyManagerType = enum {
    aws,
    customer,

    pub const json_field_names = .{
        .aws = "AWS",
        .customer = "CUSTOMER",
    };
};
