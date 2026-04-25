const ServiceDeploymentStatus = @import("service_deployment_status.zig").ServiceDeploymentStatus;

/// The service deployment properties that are retured when you call
/// `ListServiceDeployments`.
///
/// This provides a high-level overview of the service deployment.
pub const ServiceDeploymentBrief = struct {
    /// The ARN of the cluster that hosts the service.
    cluster_arn: ?[]const u8 = null,

    /// The time that the service deployment was created. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    created_at: ?i64 = null,

    /// The time that the service deployment completed. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    finished_at: ?i64 = null,

    /// The ARN of the service for this service deployment.
    service_arn: ?[]const u8 = null,

    /// The ARN of the service deployment.
    service_deployment_arn: ?[]const u8 = null,

    /// The time that the service deployment statred. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    started_at: ?i64 = null,

    /// The status of the service deployment
    status: ?ServiceDeploymentStatus = null,

    /// Information about why the service deployment is in the current status. For
    /// example, the circuit breaker detected a deployment failure.
    status_reason: ?[]const u8 = null,

    /// The ARN of the service revision being deplyed.
    target_service_revision_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .created_at = "createdAt",
        .finished_at = "finishedAt",
        .service_arn = "serviceArn",
        .service_deployment_arn = "serviceDeploymentArn",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .target_service_revision_arn = "targetServiceRevisionArn",
    };
};
