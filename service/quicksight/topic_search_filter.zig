const TopicFilterAttribute = @import("topic_filter_attribute.zig").TopicFilterAttribute;
const TopicFilterOperator = @import("topic_filter_operator.zig").TopicFilterOperator;

/// The filter that is used to search for a topic.
pub const TopicSearchFilter = struct {
    /// The name of the topic search filter.
    name: TopicFilterAttribute,

    /// The operator like equals or like.
    operator: TopicFilterOperator,

    /// The value of the topic search filter.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
