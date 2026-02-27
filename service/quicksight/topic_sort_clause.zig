const Identifier = @import("identifier.zig").Identifier;
const TopicSortDirection = @import("topic_sort_direction.zig").TopicSortDirection;

/// The definition for a `TopicSortClause`.
pub const TopicSortClause = struct {
    /// The operand for a `TopicSortClause`.
    operand: ?Identifier,

    /// The sort direction for the `TopicSortClause`.
    sort_direction: ?TopicSortDirection,

    pub const json_field_names = .{
        .operand = "Operand",
        .sort_direction = "SortDirection",
    };
};
