const HashKeyRange = @import("hash_key_range.zig").HashKeyRange;
const SequenceNumberRange = @import("sequence_number_range.zig").SequenceNumberRange;

/// A uniquely identified group of data records in a Kinesis data stream.
pub const Shard = struct {
    /// The shard ID of the shard adjacent to the shard's parent.
    adjacent_parent_shard_id: ?[]const u8 = null,

    /// The range of possible hash key values for the shard, which is a set of
    /// ordered
    /// contiguous positive integers.
    hash_key_range: HashKeyRange,

    /// The shard ID of the shard's parent.
    parent_shard_id: ?[]const u8 = null,

    /// The range of possible sequence numbers for the shard.
    sequence_number_range: SequenceNumberRange,

    /// The unique identifier of the shard within the stream.
    shard_id: []const u8,

    pub const json_field_names = .{
        .adjacent_parent_shard_id = "AdjacentParentShardId",
        .hash_key_range = "HashKeyRange",
        .parent_shard_id = "ParentShardId",
        .sequence_number_range = "SequenceNumberRange",
        .shard_id = "ShardId",
    };
};
