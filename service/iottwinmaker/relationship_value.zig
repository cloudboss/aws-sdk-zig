/// A value that associates a component and an entity.
pub const RelationshipValue = struct {
    /// The name of the target component associated with the relationship value.
    target_component_name: ?[]const u8,

    /// The ID of the target entity associated with this relationship value.
    target_entity_id: ?[]const u8,

    pub const json_field_names = .{
        .target_component_name = "targetComponentName",
        .target_entity_id = "targetEntityId",
    };
};
