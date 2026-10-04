const TopicV2DataSetRelationEndpoint = @import("topic_v2_data_set_relation_endpoint.zig").TopicV2DataSetRelationEndpoint;

/// A structure that represents a relation between two data sets of a topic.
pub const TopicV2DataSetRelation = struct {
    /// The left endpoint of the data set relation.
    left: TopicV2DataSetRelationEndpoint,

    /// The right endpoint of the data set relation.
    right: TopicV2DataSetRelationEndpoint,

    pub const json_field_names = .{
        .left = "Left",
        .right = "Right",
    };
};
