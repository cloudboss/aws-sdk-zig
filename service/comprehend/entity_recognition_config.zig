const EntityTypesListItem = @import("entity_types_list_item.zig").EntityTypesListItem;

/// Configuration required for an entity recognition model.
pub const EntityRecognitionConfig = struct {
    /// Up to 25 entity types that the model is trained to recognize.
    entity_types: []const EntityTypesListItem,

    pub const json_field_names = .{
        .entity_types = "EntityTypes",
    };
};
