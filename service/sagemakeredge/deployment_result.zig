const DeploymentModel = @import("deployment_model.zig").DeploymentModel;

/// Information about the result of a deployment on an edge device that is
/// registered with SageMaker Edge Manager.
pub const DeploymentResult = struct {
    /// The timestamp of when the deployment was ended, and the agent got the
    /// deployment results.
    deployment_end_time: ?i64 = null,

    /// Returns a list of models deployed on the agent.
    deployment_models: ?[]const DeploymentModel = null,

    /// The name and unique ID of the deployment.
    deployment_name: ?[]const u8 = null,

    /// The timestamp of when the deployment was started on the agent.
    deployment_start_time: ?i64 = null,

    /// Returns the bucket error code.
    deployment_status: ?[]const u8 = null,

    /// Returns the detailed error message.
    deployment_status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_end_time = "DeploymentEndTime",
        .deployment_models = "DeploymentModels",
        .deployment_name = "DeploymentName",
        .deployment_start_time = "DeploymentStartTime",
        .deployment_status = "DeploymentStatus",
        .deployment_status_message = "DeploymentStatusMessage",
    };
};
