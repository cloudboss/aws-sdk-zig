const GraphEntityType = @import("graph_entity_type.zig").GraphEntityType;
const FilterClause = @import("filter_clause.zig").FilterClause;

/// The pattern describing the entities to be matched during the graph query.
pub const EntityPattern = struct {
    /// The type of entity to be matched during the graph query.
    entity_type: GraphEntityType,

    filters: ?FilterClause = null,

    /// The identifier of the root entity to start traversal from during the graph
    /// query.
    identifier: []const u8,

    pub const json_field_names = .{
        .entity_type = "entityType",
        .filters = "filters",
        .identifier = "identifier",
    };
};
