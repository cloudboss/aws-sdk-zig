const CustomModelDeploymentStatus = @import("custom_model_deployment_status.zig").CustomModelDeploymentStatus;

/// Contains summary information about a custom model deployment, including its
/// ARN, name, status, and associated custom model.
pub const CustomModelDeploymentSummary = struct {
    /// The date and time when the custom model deployment was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the custom model deployment.
    custom_model_deployment_arn: []const u8,

    /// The name of the custom model deployment.
    custom_model_deployment_name: []const u8,

    /// If the deployment status is `FAILED`, this field contains a message
    /// describing the failure reason.
    failure_message: ?[]const u8,

    /// The date and time when the custom model deployment was last modified.
    last_updated_at: ?i64,

    /// The Amazon Resource Name (ARN) of the custom model associated with this
    /// deployment.
    model_arn: []const u8,

    /// The status of the custom model deployment. Possible values are `CREATING`,
    /// `ACTIVE`, and `FAILED`.
    status: CustomModelDeploymentStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .custom_model_deployment_arn = "customModelDeploymentArn",
        .custom_model_deployment_name = "customModelDeploymentName",
        .failure_message = "failureMessage",
        .last_updated_at = "lastUpdatedAt",
        .model_arn = "modelArn",
        .status = "status",
    };
};
