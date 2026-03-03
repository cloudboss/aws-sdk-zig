const SequenceNumberRange = @import("sequence_number_range.zig").SequenceNumberRange;

/// Represents a uniquely identified group of change records within a change
/// data capture stream for Amazon Keyspaces.
pub const Shard = struct {
    /// The identifiers of parent shards that this shard evolved from, if this shard
    /// was created through resharding.
    parent_shard_ids: ?[]const []const u8 = null,

    /// The range of sequence numbers contained within this shard.
    sequence_number_range: ?SequenceNumberRange = null,

    /// A unique identifier for this shard within the stream.
    shard_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .parent_shard_ids = "parentShardIds",
        .sequence_number_range = "sequenceNumberRange",
        .shard_id = "shardId",
    };
};
