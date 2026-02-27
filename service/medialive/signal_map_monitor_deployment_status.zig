/// A signal map's monitor deployment status.
pub const SignalMapMonitorDeploymentStatus = enum {
    not_deployed,
    dry_run_deployment_complete,
    dry_run_deployment_failed,
    dry_run_deployment_in_progress,
    deployment_complete,
    deployment_failed,
    deployment_in_progress,
    delete_complete,
    delete_failed,
    delete_in_progress,

    pub const json_field_names = .{
        .not_deployed = "NOT_DEPLOYED",
        .dry_run_deployment_complete = "DRY_RUN_DEPLOYMENT_COMPLETE",
        .dry_run_deployment_failed = "DRY_RUN_DEPLOYMENT_FAILED",
        .dry_run_deployment_in_progress = "DRY_RUN_DEPLOYMENT_IN_PROGRESS",
        .deployment_complete = "DEPLOYMENT_COMPLETE",
        .deployment_failed = "DEPLOYMENT_FAILED",
        .deployment_in_progress = "DEPLOYMENT_IN_PROGRESS",
        .delete_complete = "DELETE_COMPLETE",
        .delete_failed = "DELETE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
    };
};
