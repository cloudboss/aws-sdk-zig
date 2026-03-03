const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// Detailed data of an Proton service instance pipeline resource.
pub const ServicePipeline = struct {
    /// The Amazon Resource Name (ARN) of the service pipeline.
    arn: []const u8,

    /// The time when the service pipeline was created.
    created_at: i64,

    /// The deployment status of the service pipeline.
    deployment_status: DeploymentStatus,

    /// A service pipeline deployment status message.
    deployment_status_message: ?[]const u8 = null,

    /// The ID of the last attempted deployment of this service pipeline.
    last_attempted_deployment_id: ?[]const u8 = null,

    /// The time when a deployment of the service pipeline was last attempted.
    last_deployment_attempted_at: i64,

    /// The time when the service pipeline was last deployed successfully.
    last_deployment_succeeded_at: i64,

    /// The ID of the last successful deployment of this service pipeline.
    last_succeeded_deployment_id: ?[]const u8 = null,

    /// The service spec that was used to create the service pipeline.
    spec: ?[]const u8 = null,

    /// The major version of the service template that was used to create the
    /// service
    /// pipeline.
    template_major_version: []const u8,

    /// The minor version of the service template that was used to create the
    /// service
    /// pipeline.
    template_minor_version: []const u8,

    /// The name of the service template that was used to create the service
    /// pipeline.
    template_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .deployment_status = "deploymentStatus",
        .deployment_status_message = "deploymentStatusMessage",
        .last_attempted_deployment_id = "lastAttemptedDeploymentId",
        .last_deployment_attempted_at = "lastDeploymentAttemptedAt",
        .last_deployment_succeeded_at = "lastDeploymentSucceededAt",
        .last_succeeded_deployment_id = "lastSucceededDeploymentId",
        .spec = "spec",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};
