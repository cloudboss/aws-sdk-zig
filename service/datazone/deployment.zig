const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;
const DeploymentType = @import("deployment_type.zig").DeploymentType;
const EnvironmentError = @import("environment_error.zig").EnvironmentError;

/// The details of the last deployment of the environment.
pub const Deployment = struct {
    /// The identifier of the last deployment of the environment.
    deployment_id: ?[]const u8 = null,

    /// The status of the last deployment of the environment.
    deployment_status: ?DeploymentStatus = null,

    /// The type of the last deployment of the environment.
    deployment_type: ?DeploymentType = null,

    /// The failure reason of the last deployment of the environment.
    failure_reason: ?EnvironmentError = null,

    /// Specifies whether the last deployment of the environment is complete.
    is_deployment_complete: ?bool = null,

    /// The messages of the last deployment of the environment.
    messages: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .deployment_status = "deploymentStatus",
        .deployment_type = "deploymentType",
        .failure_reason = "failureReason",
        .is_deployment_complete = "isDeploymentComplete",
        .messages = "messages",
    };
};
