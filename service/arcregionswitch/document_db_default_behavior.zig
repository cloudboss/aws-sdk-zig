pub const DocumentDbDefaultBehavior = enum {
    switchover_only,
    failover,

    pub const json_field_names = .{
        .switchover_only = "SWITCHOVER_ONLY",
        .failover = "FAILOVER",
    };
};
