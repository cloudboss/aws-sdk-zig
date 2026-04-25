const DaemonStatus = @import("daemon_status.zig").DaemonStatus;

/// A summary of a daemon.
pub const DaemonSummary = struct {
    /// The Unix timestamp for the time when the daemon was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the daemon.
    daemon_arn: ?[]const u8 = null,

    /// The status of the daemon.
    status: ?DaemonStatus = null,

    /// The Unix timestamp for the time when the daemon was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .daemon_arn = "daemonArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
