pub const CRUpdateAllocationStrategy = enum {
    best_fit_progressive,
    spot_capacity_optimized,
    spot_price_capacity_optimized,

    pub const json_field_names = .{
        .best_fit_progressive = "BEST_FIT_PROGRESSIVE",
        .spot_capacity_optimized = "SPOT_CAPACITY_OPTIMIZED",
        .spot_price_capacity_optimized = "SPOT_PRICE_CAPACITY_OPTIMIZED",
    };
};
