pub const DeviceDeploymentStatus = enum {
    ready_to_deploy,
    in_progress,
    deployed,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .ready_to_deploy = "ReadyToDeploy",
        .in_progress = "InProgress",
        .deployed = "Deployed",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };
};
