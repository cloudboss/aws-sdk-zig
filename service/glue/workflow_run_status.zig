pub const WorkflowRunStatus = enum {
    running,
    completed,
    stopping,
    stopped,
    @"error",

    pub const json_field_names = .{
        .running = "RUNNING",
        .completed = "COMPLETED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .@"error" = "ERROR",
    };
};
