pub const TriggerEventType = enum {
    deployment_start,
    deployment_success,
    deployment_failure,
    deployment_stop,
    deployment_rollback,
    deployment_ready,
    instance_start,
    instance_success,
    instance_failure,
    instance_ready,

    pub const json_field_names = .{
        .deployment_start = "DEPLOYMENT_START",
        .deployment_success = "DEPLOYMENT_SUCCESS",
        .deployment_failure = "DEPLOYMENT_FAILURE",
        .deployment_stop = "DEPLOYMENT_STOP",
        .deployment_rollback = "DEPLOYMENT_ROLLBACK",
        .deployment_ready = "DEPLOYMENT_READY",
        .instance_start = "INSTANCE_START",
        .instance_success = "INSTANCE_SUCCESS",
        .instance_failure = "INSTANCE_FAILURE",
        .instance_ready = "INSTANCE_READY",
    };
};
