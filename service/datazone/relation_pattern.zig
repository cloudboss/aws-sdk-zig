const RelationDirection = @import("relation_direction.zig").RelationDirection;
const RelationType = @import("relation_type.zig").RelationType;

/// The pattern describing the query's relational traversal.
pub const RelationPattern = struct {
    /// The number of hops to query.
    max_path_length: ?i32 = null,

    /// The direction to query.
    relation_direction: RelationDirection,

    /// The type of relation to query.
    relation_type: RelationType,

    pub const json_field_names = .{
        .max_path_length = "maxPathLength",
        .relation_direction = "relationDirection",
        .relation_type = "relationType",
    };
};
