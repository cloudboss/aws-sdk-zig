const ReplicationStartingPosition = @import("replication_starting_position.zig").ReplicationStartingPosition;
const ReplicationTopicNameConfiguration = @import("replication_topic_name_configuration.zig").ReplicationTopicNameConfiguration;

/// Details about topic replication.
pub const TopicReplication = struct {
    /// Whether to periodically configure remote topic ACLs to match their
    /// corresponding upstream topics.
    copy_access_control_lists_for_topics: ?bool = null,

    /// Whether to periodically configure remote topics to match their corresponding
    /// upstream topics.
    copy_topic_configurations: ?bool = null,

    /// Whether to periodically check for new topics and partitions.
    detect_and_copy_new_topics: ?bool = null,

    /// Configuration for specifying the position in the topics to start replicating
    /// from.
    starting_position: ?ReplicationStartingPosition = null,

    /// Configuration for specifying replicated topic names should be the same as
    /// their corresponding upstream topics or prefixed with source cluster alias.
    topic_name_configuration: ?ReplicationTopicNameConfiguration = null,

    /// List of regular expression patterns indicating the topics that should not be
    /// replicated.
    topics_to_exclude: ?[]const []const u8 = null,

    /// List of regular expression patterns indicating the topics to copy.
    topics_to_replicate: []const []const u8,

    pub const json_field_names = .{
        .copy_access_control_lists_for_topics = "CopyAccessControlListsForTopics",
        .copy_topic_configurations = "CopyTopicConfigurations",
        .detect_and_copy_new_topics = "DetectAndCopyNewTopics",
        .starting_position = "StartingPosition",
        .topic_name_configuration = "TopicNameConfiguration",
        .topics_to_exclude = "TopicsToExclude",
        .topics_to_replicate = "TopicsToReplicate",
    };
};
