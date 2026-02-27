const ReplicationTopicNameConfigurationType = @import("replication_topic_name_configuration_type.zig").ReplicationTopicNameConfigurationType;

/// Configuration for specifying replicated topic names should be the same as
/// their corresponding upstream topics or prefixed with source cluster alias.
pub const ReplicationTopicNameConfiguration = struct {
    /// The type of replicated topic name.
    type: ?ReplicationTopicNameConfigurationType,

    pub const json_field_names = .{
        .type = "Type",
    };
};
