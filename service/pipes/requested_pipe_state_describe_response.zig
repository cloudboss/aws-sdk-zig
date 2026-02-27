pub const RequestedPipeStateDescribeResponse = enum {
    running,
    stopped,
    deleted,

    pub const json_field_names = .{
        .running = "RUNNING",
        .stopped = "STOPPED",
        .deleted = "DELETED",
    };
};
