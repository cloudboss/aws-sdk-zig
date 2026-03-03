const ShardFilterType = @import("shard_filter_type.zig").ShardFilterType;

/// A filter used to limit the shards returned by a `GetStream` operation.
pub const ShardFilter = struct {
    /// The identifier of a specific shard used to filter results based on the
    /// specified filter type.
    shard_id: ?[]const u8 = null,

    /// The type of shard filter to use, which determines how the shardId parameter
    /// is interpreted.
    @"type": ?ShardFilterType = null,

    pub const json_field_names = .{
        .shard_id = "shardId",
        .@"type" = "type",
    };
};
