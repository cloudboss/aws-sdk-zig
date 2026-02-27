pub const FailoverMode = enum {
    merge,
    failover,

    pub const json_field_names = .{
        .merge = "MERGE",
        .failover = "FAILOVER",
    };
};
