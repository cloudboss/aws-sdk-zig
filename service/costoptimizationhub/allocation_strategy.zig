pub const AllocationStrategy = enum {
    prioritized,
    lowest_price,

    pub const json_field_names = .{
        .prioritized = "PRIORITIZED",
        .lowest_price = "LOWEST_PRICE",
    };
};
