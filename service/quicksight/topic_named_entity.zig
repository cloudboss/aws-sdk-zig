const NamedEntityDefinition = @import("named_entity_definition.zig").NamedEntityDefinition;
const SemanticEntityType = @import("semantic_entity_type.zig").SemanticEntityType;
const NamedEntitySort = @import("named_entity_sort.zig").NamedEntitySort;

/// A structure that represents a named entity.
pub const TopicNamedEntity = struct {
    /// The definition of a named entity.
    definition: ?[]const NamedEntityDefinition = null,

    /// The description of the named entity.
    entity_description: ?[]const u8 = null,

    /// The name of the named entity.
    entity_name: []const u8,

    /// The other
    /// names or aliases for the named entity.
    entity_synonyms: ?[]const []const u8 = null,

    /// The presentation order of the named entity.
    presentation_order: ?i32 = null,

    /// The rank order of the named entity.
    rank_order: ?i32 = null,

    /// The type of named entity that a topic represents.
    semantic_entity_type: ?SemanticEntityType = null,

    /// The sort configuration of the named entity.
    sort: ?[]const NamedEntitySort = null,

    pub const json_field_names = .{
        .definition = "Definition",
        .entity_description = "EntityDescription",
        .entity_name = "EntityName",
        .entity_synonyms = "EntitySynonyms",
        .presentation_order = "PresentationOrder",
        .rank_order = "RankOrder",
        .semantic_entity_type = "SemanticEntityType",
        .sort = "Sort",
    };
};
