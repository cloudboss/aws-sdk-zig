const BotAliasReplicationStatus = @import("bot_alias_replication_status.zig").BotAliasReplicationStatus;

/// Contains information about all the aliases replication statuses applicable
/// for global resiliency.
pub const BotAliasReplicaSummary = struct {
    /// The bot alias ID for all the alias bot replications.
    bot_alias_id: ?[]const u8 = null,

    /// The replication statuses for all the alias bot replications.
    bot_alias_replication_status: ?BotAliasReplicationStatus = null,

    /// The bot version for all the alias bot replications.
    bot_version: ?[]const u8 = null,

    /// The creation time and date for all the alias bot replications.
    creation_date_time: ?i64 = null,

    /// The reasons for failure for the aliases bot replications.
    failure_reasons: ?[]const []const u8 = null,

    /// The last time and date updated for all the alias bot replications.
    last_updated_date_time: ?i64 = null,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_alias_replication_status = "botAliasReplicationStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .failure_reasons = "failureReasons",
        .last_updated_date_time = "lastUpdatedDateTime",
    };
};
