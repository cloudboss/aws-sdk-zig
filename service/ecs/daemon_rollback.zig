/// Information about a daemon deployment rollback.
pub const DaemonRollback = struct {
    /// The reason the rollback happened. For example, the circuit breaker initiated
    /// the rollback operation.
    reason: ?[]const u8 = null,

    /// The capacity providers involved in the rollback.
    rollback_capacity_providers: ?[]const []const u8 = null,

    /// The ARN of the daemon revision deployed as part of the rollback.
    rollback_target_daemon_revision_arn: ?[]const u8 = null,

    /// The time that the rollback started. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    started_at: ?i64 = null,

    pub const json_field_names = .{
        .reason = "reason",
        .rollback_capacity_providers = "rollbackCapacityProviders",
        .rollback_target_daemon_revision_arn = "rollbackTargetDaemonRevisionArn",
        .started_at = "startedAt",
    };
};
