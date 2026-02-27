pub const FailoverMode = enum {
    automatic,
    no_failover,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .no_failover = "NO_FAILOVER",
    };
};
