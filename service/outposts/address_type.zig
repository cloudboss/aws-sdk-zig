pub const AddressType = enum {
    shipping_address,
    operating_address,

    pub const json_field_names = .{
        .shipping_address = "SHIPPING_ADDRESS",
        .operating_address = "OPERATING_ADDRESS",
    };
};
