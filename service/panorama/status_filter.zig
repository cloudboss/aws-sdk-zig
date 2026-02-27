pub const StatusFilter = enum {
    deployment_succeeded,
    deployment_error,
    removal_succeeded,
    removal_failed,
    processing_deployment,
    processing_removal,
    deployment_failed,

    pub const json_field_names = .{
        .deployment_succeeded = "DEPLOYMENT_SUCCEEDED",
        .deployment_error = "DEPLOYMENT_ERROR",
        .removal_succeeded = "REMOVAL_SUCCEEDED",
        .removal_failed = "REMOVAL_FAILED",
        .processing_deployment = "PROCESSING_DEPLOYMENT",
        .processing_removal = "PROCESSING_REMOVAL",
        .deployment_failed = "DEPLOYMENT_FAILED",
    };
};
