const NamedEntityDefinition = @import("named_entity_definition.zig").NamedEntityDefinition;
const SemanticEntityType = @import("semantic_entity_type.zig").SemanticEntityType;

/// A structure that represents a named entity.
pub const TopicNamedEntity = struct {
    /// The definition of a named entity.
    definition: ?[]const NamedEntityDefinition,

    /// The description of the named entity.
    entity_description: ?[]const u8,

    /// The name of the named entity.
    entity_name: []const u8,

    /// The other
    /// names or aliases for the named entity.
    entity_synonyms: ?[]const []const u8,

    /// The type of named entity that a topic represents.
    semantic_entity_type: ?SemanticEntityType,

    pub const json_field_names = .{
        .definition = "Definition",
        .entity_description = "EntityDescription",
        .entity_name = "EntityName",
        .entity_synonyms = "EntitySynonyms",
        .semantic_entity_type = "SemanticEntityType",
    };
};
