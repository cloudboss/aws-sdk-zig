const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;
const DeploymentTargetResourceType = @import("deployment_target_resource_type.zig").DeploymentTargetResourceType;

/// Summary data of the deployment.
pub const DeploymentSummary = struct {
    /// The Amazon Resource Name (ARN) of the deployment.
    arn: []const u8,

    /// The date and time the deployment was completed.
    completed_at: ?i64,

    /// The name of the component associated with the deployment.
    component_name: ?[]const u8,

    /// The date and time the deployment was created.
    created_at: i64,

    /// The current status of the deployment.
    deployment_status: DeploymentStatus,

    /// The name of the environment associated with the deployment.
    environment_name: []const u8,

    /// The ID of the deployment.
    id: []const u8,

    /// The ID of the last attempted deployment.
    last_attempted_deployment_id: ?[]const u8,

    /// The date and time the deployment was last modified.
    last_modified_at: i64,

    /// The ID of the last successful deployment.
    last_succeeded_deployment_id: ?[]const u8,

    /// The name of the service instance associated with the deployment.
    service_instance_name: ?[]const u8,

    /// The name of the service associated with the deployment.
    service_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the target of the deployment.
    target_arn: []const u8,

    /// The date and time the target resource was created.
    target_resource_created_at: i64,

    /// The resource type of the deployment target. It can be an environment,
    /// service, service instance, or component.
    target_resource_type: DeploymentTargetResourceType,

    pub const json_field_names = .{
        .arn = "arn",
        .completed_at = "completedAt",
        .component_name = "componentName",
        .created_at = "createdAt",
        .deployment_status = "deploymentStatus",
        .environment_name = "environmentName",
        .id = "id",
        .last_attempted_deployment_id = "lastAttemptedDeploymentId",
        .last_modified_at = "lastModifiedAt",
        .last_succeeded_deployment_id = "lastSucceededDeploymentId",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
        .target_arn = "targetArn",
        .target_resource_created_at = "targetResourceCreatedAt",
        .target_resource_type = "targetResourceType",
    };
};
