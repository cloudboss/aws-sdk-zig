const ShardFilterType = @import("shard_filter_type.zig").ShardFilterType;

/// This optional field contains the filter
/// definition for the `DescribeStream` API.
pub const ShardFilter = struct {
    /// Contains the `shardId` of the parent shard for which you are requesting
    /// child shards.
    ///
    /// *Sample request:*
    shard_id: ?[]const u8,

    /// Contains the type of filter to be applied on the `DescribeStream` API.
    /// Currently, the only value this parameter accepts is `CHILD_SHARDS`.
    @"type": ?ShardFilterType,

    pub const json_field_names = .{
        .shard_id = "ShardId",
        .@"type" = "Type",
    };
};
