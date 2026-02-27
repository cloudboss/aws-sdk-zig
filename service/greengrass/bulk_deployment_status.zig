/// The current status of the bulk deployment.
pub const BulkDeploymentStatus = enum {
    initializing,
    running,
    completed,
    stopping,
    stopped,
    failed,

    pub const json_field_names = .{
        .initializing = "Initializing",
        .running = "Running",
        .completed = "Completed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .failed = "Failed",
    };
};
