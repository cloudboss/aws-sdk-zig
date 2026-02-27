/// The Promote mode requested.
pub const PromoteMode = enum {
    switchover,
    failover,

    pub const json_field_names = .{
        .switchover = "SWITCHOVER",
        .failover = "FAILOVER",
    };
};
