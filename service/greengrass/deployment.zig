const DeploymentType = @import("deployment_type.zig").DeploymentType;

/// Information about a deployment.
pub const Deployment = struct {
    /// The time, in milliseconds since the epoch, when the deployment was created.
    created_at: ?[]const u8,

    /// The ARN of the deployment.
    deployment_arn: ?[]const u8,

    /// The ID of the deployment.
    deployment_id: ?[]const u8,

    /// The type of the deployment.
    deployment_type: ?DeploymentType,

    /// The ARN of the group for this deployment.
    group_arn: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .deployment_arn = "DeploymentArn",
        .deployment_id = "DeploymentId",
        .deployment_type = "DeploymentType",
        .group_arn = "GroupArn",
    };
};
