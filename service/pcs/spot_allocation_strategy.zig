pub const SpotAllocationStrategy = enum {
    lowest_price,
    capacity_optimized,
    price_capacity_optimized,

    pub const json_field_names = .{
        .lowest_price = "LOWEST_PRICE",
        .capacity_optimized = "CAPACITY_OPTIMIZED",
        .price_capacity_optimized = "PRICE_CAPACITY_OPTIMIZED",
    };
};
