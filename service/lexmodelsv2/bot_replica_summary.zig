const BotReplicaStatus = @import("bot_replica_status.zig").BotReplicaStatus;

/// Contains summary information about all the replication statuses applicable
/// for global resiliency.
pub const BotReplicaSummary = struct {
    /// The operation status for the replicated bot applicable.
    bot_replica_status: ?BotReplicaStatus = null,

    /// The creation time and date for the replicated bots.
    creation_date_time: ?i64 = null,

    /// The reasons for the failure for the replicated bot.
    failure_reasons: ?[]const []const u8 = null,

    /// The replica region used in the replication statuses summary.
    replica_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_replica_status = "botReplicaStatus",
        .creation_date_time = "creationDateTime",
        .failure_reasons = "failureReasons",
        .replica_region = "replicaRegion",
    };
};
