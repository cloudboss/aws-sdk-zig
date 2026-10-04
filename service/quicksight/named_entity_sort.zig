const TopicSortDirection = @import("topic_sort_direction.zig").TopicSortDirection;

/// A structure that represents a sort for a named entity.
pub const NamedEntitySort = struct {
    /// The direction of the sort. Valid values are `ASCENDING` and
    /// `DESCENDING`.
    direction: TopicSortDirection,

    /// The name of the field that is used for the sort.
    field_name: []const u8,

    pub const json_field_names = .{
        .direction = "Direction",
        .field_name = "FieldName",
    };
};
