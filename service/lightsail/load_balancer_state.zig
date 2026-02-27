pub const LoadBalancerState = enum {
    active,
    provisioning,
    active_impaired,
    failed,
    unknown,

    pub const json_field_names = .{
        .active = "Active",
        .provisioning = "Provisioning",
        .active_impaired = "ActiveImpaired",
        .failed = "Failed",
        .unknown = "Unknown",
    };
};
