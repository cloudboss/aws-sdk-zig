pub const ExecutionMode = enum {
    graceful,
    ungraceful,

    pub const json_field_names = .{
        .graceful = "GRACEFUL",
        .ungraceful = "UNGRACEFUL",
    };
};
