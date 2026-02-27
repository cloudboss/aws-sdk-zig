pub const CompilationJobStatus = enum {
    inprogress,
    completed,
    failed,
    starting,
    stopping,
    stopped,

    pub const json_field_names = .{
        .inprogress = "INPROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
