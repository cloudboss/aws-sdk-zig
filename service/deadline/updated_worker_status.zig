pub const UpdatedWorkerStatus = enum {
    started,
    stopping,
    stopped,

    pub const json_field_names = .{
        .started = "STARTED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
