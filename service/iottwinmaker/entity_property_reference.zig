const aws = @import("aws");

/// An object that uniquely identifies an entity property.
pub const EntityPropertyReference = struct {
    /// The name of the component.
    component_name: ?[]const u8 = null,

    /// This string specifies the path to the composite component, starting from the
    /// top-level component.
    component_path: ?[]const u8 = null,

    /// The ID of the entity.
    entity_id: ?[]const u8 = null,

    /// A mapping of external IDs to property names. External IDs uniquely identify
    /// properties
    /// from external data stores.
    external_id_property: ?[]const aws.map.StringMapEntry = null,

    /// The name of the property.
    property_name: []const u8,

    pub const json_field_names = .{
        .component_name = "componentName",
        .component_path = "componentPath",
        .entity_id = "entityId",
        .external_id_property = "externalIdProperty",
        .property_name = "propertyName",
    };
};
