const StageStatus = @import("stage_status.zig").StageStatus;

/// Contains information summarizing the deployment stage results.
pub const EdgeDeploymentStatus = struct {
    /// The number of edge devices that failed the deployment in current stage.
    edge_deployment_failed_in_stage: i32,

    /// The number of edge devices yet to pick up the deployment in current stage,
    /// or in progress.
    edge_deployment_pending_in_stage: i32,

    /// The time when the deployment API started.
    edge_deployment_stage_start_time: ?i64,

    /// A detailed message about deployment status in current stage.
    edge_deployment_status_message: ?[]const u8,

    /// The number of edge devices with the successful deployment in the current
    /// stage.
    edge_deployment_success_in_stage: i32,

    /// The general status of the current stage.
    stage_status: StageStatus,

    pub const json_field_names = .{
        .edge_deployment_failed_in_stage = "EdgeDeploymentFailedInStage",
        .edge_deployment_pending_in_stage = "EdgeDeploymentPendingInStage",
        .edge_deployment_stage_start_time = "EdgeDeploymentStageStartTime",
        .edge_deployment_status_message = "EdgeDeploymentStatusMessage",
        .edge_deployment_success_in_stage = "EdgeDeploymentSuccessInStage",
        .stage_status = "StageStatus",
    };
};
