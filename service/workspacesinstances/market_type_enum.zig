pub const MarketTypeEnum = enum {
    spot,
    capacity_block,

    pub const json_field_names = .{
        .spot = "SPOT",
        .capacity_block = "CAPACITY_BLOCK",
    };
};
