pub const SchedulingStrategy = enum {
    replica,
    daemon,

    pub const json_field_names = .{
        .replica = "REPLICA",
        .daemon = "DAEMON",
    };
};
