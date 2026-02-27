pub const OnDemandProvisioningAllocationStrategy = enum {
    lowest_price,
    prioritized,

    pub const json_field_names = .{
        .lowest_price = "LOWEST_PRICE",
        .prioritized = "PRIORITIZED",
    };
};
