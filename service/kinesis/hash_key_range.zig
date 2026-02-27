/// The range of possible hash key values for the shard, which is a set of
/// ordered
/// contiguous positive integers.
pub const HashKeyRange = struct {
    /// The ending hash key of the hash key range.
    ending_hash_key: []const u8,

    /// The starting hash key of the hash key range.
    starting_hash_key: []const u8,

    pub const json_field_names = .{
        .ending_hash_key = "EndingHashKey",
        .starting_hash_key = "StartingHashKey",
    };
};
