const TopicV2DataSetRelation = @import("topic_v2_data_set_relation.zig").TopicV2DataSetRelation;
const TopicV2DataSetReference = @import("topic_v2_data_set_reference.zig").TopicV2DataSetReference;

/// The definition of a topic.
pub const TopicV2Details = struct {
    /// The relations between the data sets that the topic is associated with.
    data_set_relations: ?[]const TopicV2DataSetRelation = null,

    /// The data sets that the topic is associated with.
    data_sets: ?[]const TopicV2DataSetReference = null,

    /// The description of the topic.
    description: ?[]const u8 = null,

    /// The name of the topic.
    name: []const u8,

    pub const json_field_names = .{
        .data_set_relations = "DataSetRelations",
        .data_sets = "DataSets",
        .description = "Description",
        .name = "Name",
    };
};
