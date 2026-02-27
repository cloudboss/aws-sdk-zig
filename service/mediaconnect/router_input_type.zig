pub const RouterInputType = enum {
    standard,
    failover,
    merge,
    mediaconnect_flow,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .failover = "FAILOVER",
        .merge = "MERGE",
        .mediaconnect_flow = "MEDIACONNECT_FLOW",
    };
};
