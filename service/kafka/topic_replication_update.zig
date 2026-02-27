/// Details for updating the topic replication of a replicator.
pub const TopicReplicationUpdate = struct {
    /// Whether to periodically configure remote topic ACLs to match their
    /// corresponding upstream topics.
    copy_access_control_lists_for_topics: bool,

    /// Whether to periodically configure remote topics to match their corresponding
    /// upstream topics.
    copy_topic_configurations: bool,

    /// Whether to periodically check for new topics and partitions.
    detect_and_copy_new_topics: bool,

    /// List of regular expression patterns indicating the topics that should not be
    /// replicated.
    topics_to_exclude: []const []const u8,

    /// List of regular expression patterns indicating the topics to copy.
    topics_to_replicate: []const []const u8,

    pub const json_field_names = .{
        .copy_access_control_lists_for_topics = "CopyAccessControlListsForTopics",
        .copy_topic_configurations = "CopyTopicConfigurations",
        .detect_and_copy_new_topics = "DetectAndCopyNewTopics",
        .topics_to_exclude = "TopicsToExclude",
        .topics_to_replicate = "TopicsToReplicate",
    };
};
