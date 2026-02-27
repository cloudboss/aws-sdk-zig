const BotVersionReplicationStatus = @import("bot_version_replication_status.zig").BotVersionReplicationStatus;

/// Contains summary information for all the version replication statuses
/// applicable for Global resiliency.
pub const BotVersionReplicaSummary = struct {
    /// The bot version for the summary information for all the version replication
    /// statuses.
    bot_version: ?[]const u8,

    /// The version replication status for all the replicated bots.
    bot_version_replication_status: ?BotVersionReplicationStatus,

    /// The creation date and time of the replication status for all the replicated
    /// bots.
    creation_date_time: ?i64,

    /// The reasons for replication failure for all the replicated bots.
    failure_reasons: ?[]const []const u8,

    pub const json_field_names = .{
        .bot_version = "botVersion",
        .bot_version_replication_status = "botVersionReplicationStatus",
        .creation_date_time = "creationDateTime",
        .failure_reasons = "failureReasons",
    };
};
