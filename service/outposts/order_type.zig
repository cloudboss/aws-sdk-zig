pub const OrderType = enum {
    outpost,
    replacement,

    pub const json_field_names = .{
        .outpost = "OUTPOST",
        .replacement = "REPLACEMENT",
    };
};
