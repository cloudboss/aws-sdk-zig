pub const DeploymentStatus = enum {
    in_progress,
    successful,
    failed,
    pending_deployment,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .pending_deployment = "PENDING_DEPLOYMENT",
    };
};
