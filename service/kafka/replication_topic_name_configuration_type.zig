/// The type of replicated topic name.
pub const ReplicationTopicNameConfigurationType = enum {
    prefixed_with_source_cluster_alias,
    identical,

    pub const json_field_names = .{
        .prefixed_with_source_cluster_alias = "PREFIXED_WITH_SOURCE_CLUSTER_ALIAS",
        .identical = "IDENTICAL",
    };
};
