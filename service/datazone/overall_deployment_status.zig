pub const OverallDeploymentStatus = enum {
    pending_deployment,
    in_progress,
    successful,
    failed_validation,
    failed_deployment,

    pub const json_field_names = .{
        .pending_deployment = "PENDING_DEPLOYMENT",
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed_validation = "FAILED_VALIDATION",
        .failed_deployment = "FAILED_DEPLOYMENT",
    };
};
