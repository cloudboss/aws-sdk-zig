pub const ApplicationInstanceStatus = enum {
    deployment_pending,
    deployment_requested,
    deployment_in_progress,
    deployment_error,
    deployment_succeeded,
    removal_pending,
    removal_requested,
    removal_in_progress,
    removal_failed,
    removal_succeeded,
    deployment_failed,

    pub const json_field_names = .{
        .deployment_pending = "DEPLOYMENT_PENDING",
        .deployment_requested = "DEPLOYMENT_REQUESTED",
        .deployment_in_progress = "DEPLOYMENT_IN_PROGRESS",
        .deployment_error = "DEPLOYMENT_ERROR",
        .deployment_succeeded = "DEPLOYMENT_SUCCEEDED",
        .removal_pending = "REMOVAL_PENDING",
        .removal_requested = "REMOVAL_REQUESTED",
        .removal_in_progress = "REMOVAL_IN_PROGRESS",
        .removal_failed = "REMOVAL_FAILED",
        .removal_succeeded = "REMOVAL_SUCCEEDED",
        .deployment_failed = "DEPLOYMENT_FAILED",
    };
};
