const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// Summary data of an Proton component resource.
///
/// For more information about components, see
/// [Proton
/// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
/// *Proton User Guide*.
pub const ComponentSummary = struct {
    /// The Amazon Resource Name (ARN) of the component.
    arn: []const u8,

    /// The time when the component was created.
    created_at: i64,

    /// The component deployment status.
    deployment_status: DeploymentStatus,

    /// The message associated with the component deployment status.
    deployment_status_message: ?[]const u8 = null,

    /// The name of the Proton environment that this component is associated with.
    environment_name: []const u8,

    /// The ID of the last attempted deployment of this component.
    last_attempted_deployment_id: ?[]const u8 = null,

    /// The time when a deployment of the component was last attempted.
    last_deployment_attempted_at: ?i64 = null,

    /// The time when the component was last deployed successfully.
    last_deployment_succeeded_at: ?i64 = null,

    /// The time when the component was last modified.
    last_modified_at: i64,

    /// The ID of the last successful deployment of this component.
    last_succeeded_deployment_id: ?[]const u8 = null,

    /// The name of the component.
    name: []const u8,

    /// The name of the service instance that this component is attached to.
    /// Provided when a component is attached to a service instance.
    service_instance_name: ?[]const u8 = null,

    /// The name of the service that `serviceInstanceName` is associated with.
    /// Provided when a component is attached to a service instance.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .deployment_status = "deploymentStatus",
        .deployment_status_message = "deploymentStatusMessage",
        .environment_name = "environmentName",
        .last_attempted_deployment_id = "lastAttemptedDeploymentId",
        .last_deployment_attempted_at = "lastDeploymentAttemptedAt",
        .last_deployment_succeeded_at = "lastDeploymentSucceededAt",
        .last_modified_at = "lastModifiedAt",
        .last_succeeded_deployment_id = "lastSucceededDeploymentId",
        .name = "name",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
    };
};
