const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// Detailed data of an Proton service instance resource.
pub const ServiceInstance = struct {
    /// The Amazon Resource Name (ARN) of the service instance.
    arn: []const u8,

    /// The time when the service instance was created.
    created_at: i64,

    /// The service instance deployment status.
    deployment_status: DeploymentStatus,

    /// The message associated with the service instance deployment status.
    deployment_status_message: ?[]const u8 = null,

    /// The name of the environment that the service instance was deployed into.
    environment_name: []const u8,

    /// The ID of the last attempted deployment of this service instance.
    last_attempted_deployment_id: ?[]const u8 = null,

    /// The last client request token received.
    last_client_request_token: ?[]const u8 = null,

    /// The time when a deployment of the service instance was last attempted.
    last_deployment_attempted_at: i64,

    /// The time when the service instance was last deployed successfully.
    last_deployment_succeeded_at: i64,

    /// The ID of the last successful deployment of this service instance.
    last_succeeded_deployment_id: ?[]const u8 = null,

    /// The name of the service instance.
    name: []const u8,

    /// The name of the service that the service instance belongs to.
    service_name: []const u8,

    /// The service spec that was used to create the service instance.
    spec: ?[]const u8 = null,

    /// The major version of the service template that was used to create the
    /// service
    /// instance.
    template_major_version: []const u8,

    /// The minor version of the service template that was used to create the
    /// service
    /// instance.
    template_minor_version: []const u8,

    /// The name of the service template that was used to create the service
    /// instance.
    template_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .deployment_status = "deploymentStatus",
        .deployment_status_message = "deploymentStatusMessage",
        .environment_name = "environmentName",
        .last_attempted_deployment_id = "lastAttemptedDeploymentId",
        .last_client_request_token = "lastClientRequestToken",
        .last_deployment_attempted_at = "lastDeploymentAttemptedAt",
        .last_deployment_succeeded_at = "lastDeploymentSucceededAt",
        .last_succeeded_deployment_id = "lastSucceededDeploymentId",
        .name = "name",
        .service_name = "serviceName",
        .spec = "spec",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};
