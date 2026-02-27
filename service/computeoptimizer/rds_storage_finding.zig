pub const RDSStorageFinding = enum {
    optimized,
    under_provisioned,
    over_provisioned,
    not_optimized,

    pub const json_field_names = .{
        .optimized = "OPTIMIZED",
        .under_provisioned = "UNDER_PROVISIONED",
        .over_provisioned = "OVER_PROVISIONED",
        .not_optimized = "NOT_OPTIMIZED",
    };
};
