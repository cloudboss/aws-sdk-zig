const CustomModelDeploymentUpdateStatus = @import("custom_model_deployment_update_status.zig").CustomModelDeploymentUpdateStatus;

/// Details about an update to a custom model deployment, including the new
/// custom model resource ARN and current update status.
pub const CustomModelDeploymentUpdateDetails = struct {
    /// ARN of the new custom model being deployed as part of the update.
    model_arn: []const u8,

    /// Current status of the deployment update.
    update_status: CustomModelDeploymentUpdateStatus,

    pub const json_field_names = .{
        .model_arn = "modelArn",
        .update_status = "updateStatus",
    };
};
