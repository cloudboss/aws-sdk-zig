pub const RDSInstanceFinding = enum {
    optimized,
    under_provisioned,
    over_provisioned,

    pub const json_field_names = .{
        .optimized = "OPTIMIZED",
        .under_provisioned = "UNDER_PROVISIONED",
        .over_provisioned = "OVER_PROVISIONED",
    };
};
