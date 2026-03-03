const SequenceNumberRange = @import("sequence_number_range.zig").SequenceNumberRange;

/// A uniquely identified group of stream records within a stream.
pub const Shard = struct {
    /// The shard ID of the current shard's parent.
    parent_shard_id: ?[]const u8 = null,

    /// The range of possible sequence numbers for the shard.
    sequence_number_range: ?SequenceNumberRange = null,

    /// The system-generated identifier for this shard.
    shard_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .parent_shard_id = "ParentShardId",
        .sequence_number_range = "SequenceNumberRange",
        .shard_id = "ShardId",
    };
};
