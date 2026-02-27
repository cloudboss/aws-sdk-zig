pub const Finding = enum {
    under_provisioned,
    over_provisioned,
    optimized,
    not_optimized,

    pub const json_field_names = .{
        .under_provisioned = "UNDER_PROVISIONED",
        .over_provisioned = "OVER_PROVISIONED",
        .optimized = "OPTIMIZED",
        .not_optimized = "NOT_OPTIMIZED",
    };
};
