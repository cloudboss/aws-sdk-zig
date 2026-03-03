/// Includes identification info about the topic.
pub const TopicInfo = struct {
    /// Number of out-of-sync replicas for a topic.
    out_of_sync_replica_count: ?i32 = null,

    /// Partition count for a topic.
    partition_count: ?i32 = null,

    /// Replication factor for a topic.
    replication_factor: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the topic.
    topic_arn: ?[]const u8 = null,

    /// Name for a topic.
    topic_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .out_of_sync_replica_count = "OutOfSyncReplicaCount",
        .partition_count = "PartitionCount",
        .replication_factor = "ReplicationFactor",
        .topic_arn = "TopicArn",
        .topic_name = "TopicName",
    };
};
