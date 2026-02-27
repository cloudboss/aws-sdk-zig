pub const DeviceReportedStatus = enum {
    stopping,
    stopped,
    stop_error,
    removal_failed,
    removal_in_progress,
    starting,
    running,
    install_error,
    launched,
    launch_error,
    install_in_progress,

    pub const json_field_names = .{
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .stop_error = "STOP_ERROR",
        .removal_failed = "REMOVAL_FAILED",
        .removal_in_progress = "REMOVAL_IN_PROGRESS",
        .starting = "STARTING",
        .running = "RUNNING",
        .install_error = "INSTALL_ERROR",
        .launched = "LAUNCHED",
        .launch_error = "LAUNCH_ERROR",
        .install_in_progress = "INSTALL_IN_PROGRESS",
    };
};
