pub const DocumentDbUngracefulBehavior = enum {
    failover,

    pub const json_field_names = .{
        .failover = "FAILOVER",
    };
};
