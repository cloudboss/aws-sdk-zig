pub const StageStatus = enum {
    creating,
    ready_to_deploy,
    starting,
    in_progress,
    deployed,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .creating = "Creating",
        .ready_to_deploy = "ReadyToDeploy",
        .starting = "Starting",
        .in_progress = "InProgress",
        .deployed = "Deployed",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };
};
