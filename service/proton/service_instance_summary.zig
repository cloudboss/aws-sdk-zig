const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// Summary data of an Proton service instance resource.
pub const ServiceInstanceSummary = struct {
    /// The Amazon Resource Name (ARN) of the service instance.
    arn: []const u8,

    /// The time when the service instance was created.
    created_at: i64,

    /// The service instance deployment status.
    deployment_status: DeploymentStatus,

    /// A service instance deployment status message.
    deployment_status_message: ?[]const u8,

    /// The name of the environment that the service instance was deployed into.
    environment_name: []const u8,

    /// The ID of the last attempted deployment of this service instance.
    last_attempted_deployment_id: ?[]const u8,

    /// The time when a deployment of the service was last attempted.
    last_deployment_attempted_at: i64,

    /// The time when the service was last deployed successfully.
    last_deployment_succeeded_at: i64,

    /// The ID of the last successful deployment of this service instance.
    last_succeeded_deployment_id: ?[]const u8,

    /// The name of the service instance.
    name: []const u8,

    /// The name of the service that the service instance belongs to.
    service_name: []const u8,

    /// The service instance template major version.
    template_major_version: []const u8,

    /// The service instance template minor version.
    template_minor_version: []const u8,

    /// The name of the service template.
    template_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .deployment_status = "deploymentStatus",
        .deployment_status_message = "deploymentStatusMessage",
        .environment_name = "environmentName",
        .last_attempted_deployment_id = "lastAttemptedDeploymentId",
        .last_deployment_attempted_at = "lastDeploymentAttemptedAt",
        .last_deployment_succeeded_at = "lastDeploymentSucceededAt",
        .last_succeeded_deployment_id = "lastSucceededDeploymentId",
        .name = "name",
        .service_name = "serviceName",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};
