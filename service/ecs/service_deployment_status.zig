pub const ServiceDeploymentStatus = enum {
    pending,
    successful,
    stopped,
    stop_requested,
    in_progress,
    rollback_requested,
    rollback_in_progress,
    rollback_successful,
    rollback_failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .successful = "SUCCESSFUL",
        .stopped = "STOPPED",
        .stop_requested = "STOP_REQUESTED",
        .in_progress = "IN_PROGRESS",
        .rollback_requested = "ROLLBACK_REQUESTED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_successful = "ROLLBACK_SUCCESSFUL",
        .rollback_failed = "ROLLBACK_FAILED",
    };
};
