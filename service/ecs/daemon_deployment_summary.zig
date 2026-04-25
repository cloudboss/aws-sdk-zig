const DaemonDeploymentStatus = @import("daemon_deployment_status.zig").DaemonDeploymentStatus;

/// A summary of a daemon deployment.
pub const DaemonDeploymentSummary = struct {
    /// The Amazon Resource Name (ARN) of the cluster that hosts the daemon.
    cluster_arn: ?[]const u8 = null,

    /// The time the daemon deployment was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the daemon.
    daemon_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the daemon deployment.
    daemon_deployment_arn: ?[]const u8 = null,

    /// The time the daemon deployment finished.
    finished_at: ?i64 = null,

    /// The time the daemon deployment started.
    started_at: ?i64 = null,

    /// The status of the daemon deployment.
    status: ?DaemonDeploymentStatus = null,

    /// Information about why the daemon deployment is in the current status.
    status_reason: ?[]const u8 = null,

    /// The time the daemon deployment stopped.
    stopped_at: ?i64 = null,

    /// The ARN of the daemon revision being deployed.
    target_daemon_revision_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .created_at = "createdAt",
        .daemon_arn = "daemonArn",
        .daemon_deployment_arn = "daemonDeploymentArn",
        .finished_at = "finishedAt",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
        .target_daemon_revision_arn = "targetDaemonRevisionArn",
    };
};
