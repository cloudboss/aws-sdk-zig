pub const InstalledComponentLifecycleState = enum {
    new,
    installed,
    starting,
    running,
    stopping,
    errored,
    broken,
    finished,

    pub const json_field_names = .{
        .new = "NEW",
        .installed = "INSTALLED",
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .errored = "ERRORED",
        .broken = "BROKEN",
        .finished = "FINISHED",
    };
};
