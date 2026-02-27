pub const PaymentOption = enum {
    no_upfront,
    partial_upfront,
    all_upfront,
    light_utilization,
    medium_utilization,
    heavy_utilization,

    pub const json_field_names = .{
        .no_upfront = "NO_UPFRONT",
        .partial_upfront = "PARTIAL_UPFRONT",
        .all_upfront = "ALL_UPFRONT",
        .light_utilization = "LIGHT_UTILIZATION",
        .medium_utilization = "MEDIUM_UTILIZATION",
        .heavy_utilization = "HEAVY_UTILIZATION",
    };
};
