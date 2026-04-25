const DaemonRevisionDetail = @import("daemon_revision_detail.zig").DaemonRevisionDetail;
const DaemonStatus = @import("daemon_status.zig").DaemonStatus;

/// The detailed information about a daemon.
pub const DaemonDetail = struct {
    /// The Amazon Resource Name (ARN) of the cluster that the daemon is running in.
    cluster_arn: ?[]const u8 = null,

    /// The Unix timestamp for the time when the daemon was created.
    created_at: ?i64 = null,

    /// The current daemon revision details, including the running task counts per
    /// capacity provider.
    current_revisions: ?[]const DaemonRevisionDetail = null,

    /// The Amazon Resource Name (ARN) of the daemon.
    daemon_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the most recent daemon deployment.
    deployment_arn: ?[]const u8 = null,

    /// The status of the daemon.
    status: ?DaemonStatus = null,

    /// The Unix timestamp for the time when the daemon was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .created_at = "createdAt",
        .current_revisions = "currentRevisions",
        .daemon_arn = "daemonArn",
        .deployment_arn = "deploymentArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
