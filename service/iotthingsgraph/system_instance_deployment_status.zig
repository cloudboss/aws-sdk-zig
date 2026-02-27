pub const SystemInstanceDeploymentStatus = enum {
    not_deployed,
    bootstrap,
    deploy_in_progress,
    deployed_in_target,
    undeploy_in_progress,
    failed,
    pending_delete,
    deleted_in_target,

    pub const json_field_names = .{
        .not_deployed = "NOT_DEPLOYED",
        .bootstrap = "BOOTSTRAP",
        .deploy_in_progress = "DEPLOY_IN_PROGRESS",
        .deployed_in_target = "DEPLOYED_IN_TARGET",
        .undeploy_in_progress = "UNDEPLOY_IN_PROGRESS",
        .failed = "FAILED",
        .pending_delete = "PENDING_DELETE",
        .deleted_in_target = "DELETED_IN_TARGET",
    };
};
