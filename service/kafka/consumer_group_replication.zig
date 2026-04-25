const ConsumerGroupOffsetSyncMode = @import("consumer_group_offset_sync_mode.zig").ConsumerGroupOffsetSyncMode;

/// Details about consumer group replication.
pub const ConsumerGroupReplication = struct {
    /// The consumer group offset synchronization mode. With LEGACY, offsets are
    /// synchronized when producers write to the source cluster. With ENHANCED,
    /// consumer offsets are synchronized regardless of producer location. ENHANCED
    /// requires a corresponding replicator that replicates data from the target
    /// cluster to the source cluster.
    consumer_group_offset_sync_mode: ?ConsumerGroupOffsetSyncMode = null,

    /// List of regular expression patterns indicating the consumer groups that
    /// should not be replicated.
    consumer_groups_to_exclude: ?[]const []const u8 = null,

    /// List of regular expression patterns indicating the consumer groups to copy.
    consumer_groups_to_replicate: []const []const u8,

    /// Enables synchronization of consumer groups to target cluster.
    detect_and_copy_new_consumer_groups: ?bool = null,

    /// Enables synchronization of consumer group offsets to target cluster. The
    /// translated offsets will be written to topic __consumer_offsets.
    synchronise_consumer_group_offsets: ?bool = null,

    pub const json_field_names = .{
        .consumer_group_offset_sync_mode = "ConsumerGroupOffsetSyncMode",
        .consumer_groups_to_exclude = "ConsumerGroupsToExclude",
        .consumer_groups_to_replicate = "ConsumerGroupsToReplicate",
        .detect_and_copy_new_consumer_groups = "DetectAndCopyNewConsumerGroups",
        .synchronise_consumer_group_offsets = "SynchroniseConsumerGroupOffsets",
    };
};
