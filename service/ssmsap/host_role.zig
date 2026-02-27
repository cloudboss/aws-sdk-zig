pub const HostRole = enum {
    leader,
    worker,
    standby,
    unknown,

    pub const json_field_names = .{
        .leader = "LEADER",
        .worker = "WORKER",
        .standby = "STANDBY",
        .unknown = "UNKNOWN",
    };
};
