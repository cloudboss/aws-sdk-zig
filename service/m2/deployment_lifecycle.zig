pub const DeploymentLifecycle = enum {
    deploying,
    succeeded,
    failed,
    deploy_update,

    pub const json_field_names = .{
        .deploying = "DEPLOYING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .deploy_update = "DEPLOY_UPDATE",
    };
};
