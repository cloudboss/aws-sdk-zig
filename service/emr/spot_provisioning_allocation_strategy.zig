pub const SpotProvisioningAllocationStrategy = enum {
    capacity_optimized,
    price_capacity_optimized,
    lowest_price,
    diversified,
    capacity_optimized_prioritized,

    pub const json_field_names = .{
        .capacity_optimized = "CAPACITY_OPTIMIZED",
        .price_capacity_optimized = "PRICE_CAPACITY_OPTIMIZED",
        .lowest_price = "LOWEST_PRICE",
        .diversified = "DIVERSIFIED",
        .capacity_optimized_prioritized = "CAPACITY_OPTIMIZED_PRIORITIZED",
    };
};
