const EntityPattern = @import("entity_pattern.zig").EntityPattern;
const RelationPattern = @import("relation_pattern.zig").RelationPattern;

/// A clause to match a query pattern
pub const MatchClause = union(enum) {
    /// The pattern describing the entities for the query to traverse.
    entity_pattern: ?EntityPattern,
    /// The pattern describing the query's relational traversal.
    relation_pattern: ?RelationPattern,

    pub const json_field_names = .{
        .entity_pattern = "entityPattern",
        .relation_pattern = "relationPattern",
    };
};
