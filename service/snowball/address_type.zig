pub const AddressType = enum {
    cust_pickup,
    aws_ship,

    pub const json_field_names = .{
        .cust_pickup = "CUST_PICKUP",
        .aws_ship = "AWS_SHIP",
    };
};
