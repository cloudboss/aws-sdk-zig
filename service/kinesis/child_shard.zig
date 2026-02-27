const HashKeyRange = @import("hash_key_range.zig").HashKeyRange;

/// Output parameter of the GetRecords API. The existing child shard of the
/// current
/// shard.
pub const ChildShard = struct {
    hash_key_range: HashKeyRange,

    /// The current shard that is the parent of the existing child shard.
    parent_shards: []const []const u8,

    /// The shard ID of the existing child shard of the current shard.
    shard_id: []const u8,

    pub const json_field_names = .{
        .hash_key_range = "HashKeyRange",
        .parent_shards = "ParentShards",
        .shard_id = "ShardId",
    };
};
