const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// Contains information about a deployment.
pub const Deployment = struct {
    /// The time at which the deployment was created, expressed in ISO 8601 format.
    creation_timestamp: ?i64,

    /// The ID of the deployment.
    deployment_id: ?[]const u8,

    /// The name of the deployment.
    deployment_name: ?[]const u8,

    /// The status of the deployment.
    deployment_status: ?DeploymentStatus,

    /// Whether or not the deployment is the latest revision for its target.
    is_latest_for_target: bool = false,

    /// The parent deployment's target
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) within a subdeployment.
    parent_target_arn: ?[]const u8,

    /// The revision number of the deployment.
    revision_id: ?[]const u8,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the target IoT thing or thing group. When creating a subdeployment, the targetARN can only be a thing group.
    target_arn: ?[]const u8,

    pub const json_field_names = .{
        .creation_timestamp = "creationTimestamp",
        .deployment_id = "deploymentId",
        .deployment_name = "deploymentName",
        .deployment_status = "deploymentStatus",
        .is_latest_for_target = "isLatestForTarget",
        .parent_target_arn = "parentTargetArn",
        .revision_id = "revisionId",
        .target_arn = "targetArn",
    };
};
