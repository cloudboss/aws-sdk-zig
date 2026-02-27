const ModelState = @import("model_state.zig").ModelState;
const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

pub const DeploymentModel = struct {
    /// The desired state of the model.
    desired_state: ?ModelState,

    /// The unique handle of the model.
    model_handle: ?[]const u8,

    /// The name of the model.
    model_name: ?[]const u8,

    /// The version of the model.
    model_version: ?[]const u8,

    /// Returns the error message if there is a rollback.
    rollback_failure_reason: ?[]const u8,

    /// Returns the current state of the model.
    state: ?ModelState,

    /// Returns the deployment status of the model.
    status: ?DeploymentStatus,

    /// Returns the error message for the deployment status result.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .desired_state = "DesiredState",
        .model_handle = "ModelHandle",
        .model_name = "ModelName",
        .model_version = "ModelVersion",
        .rollback_failure_reason = "RollbackFailureReason",
        .state = "State",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
