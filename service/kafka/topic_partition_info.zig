/// Contains information about a topic partition.
pub const TopicPartitionInfo = struct {
    /// The list of in-sync replica broker IDs for the partition.
    isr: ?[]const i32,

    /// The leader broker ID for the partition.
    leader: ?i32,

    /// The partition ID.
    partition: ?i32,

    /// The list of replica broker IDs for the partition.
    replicas: ?[]const i32,

    pub const json_field_names = .{
        .isr = "Isr",
        .leader = "Leader",
        .partition = "Partition",
        .replicas = "Replicas",
    };
};
