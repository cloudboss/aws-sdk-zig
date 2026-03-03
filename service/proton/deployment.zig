const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;
const DeploymentState = @import("deployment_state.zig").DeploymentState;
const DeploymentTargetResourceType = @import("deployment_target_resource_type.zig").DeploymentTargetResourceType;

/// The detailed information about a deployment.
pub const Deployment = struct {
    /// The Amazon Resource Name (ARN) of the deployment.
    arn: []const u8,

    /// The date and time the deployment was completed.
    completed_at: ?i64 = null,

    /// The name of the component associated with this deployment.
    component_name: ?[]const u8 = null,

    /// The date and time the deployment was created.
    created_at: i64,

    /// The status of the deployment.
    deployment_status: DeploymentStatus,

    /// The deployment status message.
    deployment_status_message: ?[]const u8 = null,

    /// The name of the environment associated with this deployment.
    environment_name: []const u8,

    /// The ID of the deployment.
    id: []const u8,

    /// The initial state of the target resource at the time of the deployment.
    initial_state: ?DeploymentState = null,

    /// The ID of the last attempted deployment.
    last_attempted_deployment_id: ?[]const u8 = null,

    /// The date and time the deployment was last modified.
    last_modified_at: i64,

    /// The ID of the last successful deployment.
    last_succeeded_deployment_id: ?[]const u8 = null,

    /// The name of the deployment's service instance.
    service_instance_name: ?[]const u8 = null,

    /// The name of the service in this deployment.
    service_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the target of the deployment.
    target_arn: []const u8,

    /// The date and time the depoyment target was created.
    target_resource_created_at: i64,

    /// The resource type of the deployment target. It can be an environment,
    /// service, service instance, or component.
    target_resource_type: DeploymentTargetResourceType,

    /// The target state of the target resource at the time of the deployment.
    target_state: ?DeploymentState = null,

    pub const json_field_names = .{
        .arn = "arn",
        .completed_at = "completedAt",
        .component_name = "componentName",
        .created_at = "createdAt",
        .deployment_status = "deploymentStatus",
        .deployment_status_message = "deploymentStatusMessage",
        .environment_name = "environmentName",
        .id = "id",
        .initial_state = "initialState",
        .last_attempted_deployment_id = "lastAttemptedDeploymentId",
        .last_modified_at = "lastModifiedAt",
        .last_succeeded_deployment_id = "lastSucceededDeploymentId",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
        .target_arn = "targetArn",
        .target_resource_created_at = "targetResourceCreatedAt",
        .target_resource_type = "targetResourceType",
        .target_state = "targetState",
    };
};
