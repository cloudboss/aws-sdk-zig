pub const DeploymentRolloutState = enum {
    completed,
    failed,
    in_progress,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
    };
};
