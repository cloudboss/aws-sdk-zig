pub const GameServerInstanceStatus = enum {
    active,
    draining,
    spot_terminating,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .draining = "DRAINING",
        .spot_terminating = "SPOT_TERMINATING",
    };
};
