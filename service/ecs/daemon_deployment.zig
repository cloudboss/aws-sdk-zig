const DaemonDeploymentAlarms = @import("daemon_deployment_alarms.zig").DaemonDeploymentAlarms;
const DaemonCircuitBreaker = @import("daemon_circuit_breaker.zig").DaemonCircuitBreaker;
const DaemonDeploymentConfiguration = @import("daemon_deployment_configuration.zig").DaemonDeploymentConfiguration;
const DaemonRollback = @import("daemon_rollback.zig").DaemonRollback;
const DaemonDeploymentRevisionDetail = @import("daemon_deployment_revision_detail.zig").DaemonDeploymentRevisionDetail;
const DaemonDeploymentStatus = @import("daemon_deployment_status.zig").DaemonDeploymentStatus;

/// Information about a daemon deployment. A daemon deployment orchestrates the
/// progressive rollout of daemon task updates across container instances.
pub const DaemonDeployment = struct {
    /// The CloudWatch alarms that determine when a daemon deployment fails.
    alarms: ?DaemonDeploymentAlarms = null,

    /// The circuit breaker configuration that determines when a daemon deployment
    /// has failed.
    circuit_breaker: ?DaemonCircuitBreaker = null,

    /// The Amazon Resource Name (ARN) of the cluster that hosts the daemon.
    cluster_arn: ?[]const u8 = null,

    /// The time the daemon deployment was created. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the daemon deployment.
    daemon_deployment_arn: ?[]const u8 = null,

    /// The deployment configuration used for this daemon deployment.
    deployment_configuration: ?DaemonDeploymentConfiguration = null,

    /// The time the daemon deployment finished. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    finished_at: ?i64 = null,

    /// The rollback options for the daemon deployment.
    rollback: ?DaemonRollback = null,

    /// The currently deployed daemon revisions that are being replaced.
    source_daemon_revisions: ?[]const DaemonDeploymentRevisionDetail = null,

    /// The time the daemon deployment started. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    started_at: ?i64 = null,

    /// The status of the daemon deployment.
    status: ?DaemonDeploymentStatus = null,

    /// Information about why the daemon deployment is in the current status.
    status_reason: ?[]const u8 = null,

    /// The time the daemon deployment stopped. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    stopped_at: ?i64 = null,

    /// The daemon revision being deployed.
    target_daemon_revision: ?DaemonDeploymentRevisionDetail = null,

    pub const json_field_names = .{
        .alarms = "alarms",
        .circuit_breaker = "circuitBreaker",
        .cluster_arn = "clusterArn",
        .created_at = "createdAt",
        .daemon_deployment_arn = "daemonDeploymentArn",
        .deployment_configuration = "deploymentConfiguration",
        .finished_at = "finishedAt",
        .rollback = "rollback",
        .source_daemon_revisions = "sourceDaemonRevisions",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
        .target_daemon_revision = "targetDaemonRevision",
    };
};
