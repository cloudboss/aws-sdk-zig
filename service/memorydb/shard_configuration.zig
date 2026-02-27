/// Shard configuration options. Each shard configuration has the following:
/// Slots and ReplicaCount.
pub const ShardConfiguration = struct {
    /// The number of read replica nodes in this shard.
    replica_count: ?i32,

    /// A string that specifies the keyspace for a particular node group. Keyspaces
    /// range from 0 to 16,383. The string is in the format startkey-endkey.
    slots: ?[]const u8,

    pub const json_field_names = .{
        .replica_count = "ReplicaCount",
        .slots = "Slots",
    };
};
