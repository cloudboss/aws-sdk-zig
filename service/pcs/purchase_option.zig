pub const PurchaseOption = enum {
    ondemand,
    spot,
    capacity_block,

    pub const json_field_names = .{
        .ondemand = "ONDEMAND",
        .spot = "SPOT",
        .capacity_block = "CAPACITY_BLOCK",
    };
};
