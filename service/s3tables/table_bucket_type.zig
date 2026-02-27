pub const TableBucketType = enum {
    customer,
    aws,

    pub const json_field_names = .{
        .customer = "CUSTOMER",
        .aws = "AWS",
    };
};
