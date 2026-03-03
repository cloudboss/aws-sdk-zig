const DeploymentType = @import("deployment_type.zig").DeploymentType;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// Information about an individual group deployment in a bulk deployment
/// operation.
pub const BulkDeploymentResult = struct {
    /// The time, in ISO format, when the deployment was created.
    created_at: ?[]const u8 = null,

    /// The ARN of the group deployment.
    deployment_arn: ?[]const u8 = null,

    /// The ID of the group deployment.
    deployment_id: ?[]const u8 = null,

    /// The current status of the group deployment: ''InProgress'', ''Building'',
    /// ''Success'', or ''Failure''.
    deployment_status: ?[]const u8 = null,

    /// The type of the deployment.
    deployment_type: ?DeploymentType = null,

    /// Details about the error.
    error_details: ?[]const ErrorDetail = null,

    /// The error message for a failed deployment
    error_message: ?[]const u8 = null,

    /// The ARN of the Greengrass group.
    group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .deployment_arn = "DeploymentArn",
        .deployment_id = "DeploymentId",
        .deployment_status = "DeploymentStatus",
        .deployment_type = "DeploymentType",
        .error_details = "ErrorDetails",
        .error_message = "ErrorMessage",
        .group_arn = "GroupArn",
    };
};
