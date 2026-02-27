pub const ClusterState = enum {
    starting,
    bootstrapping,
    running,
    waiting,
    terminating,
    terminated,
    terminated_with_errors,

    pub const json_field_names = .{
        .starting = "STARTING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .waiting = "WAITING",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .terminated_with_errors = "TERMINATED_WITH_ERRORS",
    };
};
