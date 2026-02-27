/// An object that filters items in a list of entities.
pub const ListEntitiesFilter = union(enum) {
    /// The ID of the component type in the entities in the list.
    component_type_id: ?[]const u8,
    /// The external-Id property of a component. The external-Id property is the
    /// primary key of
    /// an external storage system.
    external_id: ?[]const u8,
    /// The parent of the entities in the list.
    parent_entity_id: ?[]const u8,

    pub const json_field_names = .{
        .component_type_id = "componentTypeId",
        .external_id = "externalId",
        .parent_entity_id = "parentEntityId",
    };
};
