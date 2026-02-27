pub const ClusterInstanceStatus = enum {
    running,
    failure,
    pending,
    shutting_down,
    system_updating,
    deep_health_check_in_progress,
    not_found,

    pub const json_field_names = .{
        .running = "RUNNING",
        .failure = "FAILURE",
        .pending = "PENDING",
        .shutting_down = "SHUTTING_DOWN",
        .system_updating = "SYSTEM_UPDATING",
        .deep_health_check_in_progress = "DEEP_HEALTH_CHECK_IN_PROGRESS",
        .not_found = "NOT_FOUND",
    };
};
