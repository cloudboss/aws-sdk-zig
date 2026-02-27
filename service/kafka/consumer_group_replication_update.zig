/// Details about consumer group replication.
pub const ConsumerGroupReplicationUpdate = struct {
    /// List of regular expression patterns indicating the consumer groups that
    /// should not be replicated.
    consumer_groups_to_exclude: []const []const u8,

    /// List of regular expression patterns indicating the consumer groups to copy.
    consumer_groups_to_replicate: []const []const u8,

    /// Enables synchronization of consumer groups to target cluster.
    detect_and_copy_new_consumer_groups: bool,

    /// Enables synchronization of consumer group offsets to target cluster. The
    /// translated offsets will be written to topic __consumer_offsets.
    synchronise_consumer_group_offsets: bool,

    pub const json_field_names = .{
        .consumer_groups_to_exclude = "ConsumerGroupsToExclude",
        .consumer_groups_to_replicate = "ConsumerGroupsToReplicate",
        .detect_and_copy_new_consumer_groups = "DetectAndCopyNewConsumerGroups",
        .synchronise_consumer_group_offsets = "SynchroniseConsumerGroupOffsets",
    };
};
