const DefinitionDocument = @import("definition_document.zig").DefinitionDocument;
const EntityType = @import("entity_type.zig").EntityType;

/// Describes the properties of an entity.
pub const EntityDescription = struct {
    /// The entity ARN.
    arn: ?[]const u8,

    /// The time at which the entity was created.
    created_at: ?i64,

    /// The definition document of the entity.
    definition: ?DefinitionDocument,

    /// The entity ID.
    id: ?[]const u8,

    /// The entity type.
    type: ?EntityType,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .definition = "definition",
        .id = "id",
        .type = "type",
    };
};
