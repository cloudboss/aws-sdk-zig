const aws = @import("aws");

/// An entity supported by a given `ConnectionType`.
pub const Entity = struct {
    /// The type of entities that are present in the response. This value depends on
    /// the source connection. For example this is `SObjects` for Salesforce and
    /// `databases` or `schemas` or `tables` for sources like Amazon Redshift.
    category: ?[]const u8,

    /// An optional map of keys which may be returned for an entity by a connector.
    custom_properties: ?[]const aws.map.StringMapEntry,

    /// A description of the entity.
    description: ?[]const u8,

    /// The name of the entity.
    entity_name: ?[]const u8,

    /// A Boolean value which helps to determine whether there are sub objects that
    /// can be listed.
    is_parent_entity: ?bool,

    /// Label used for the entity.
    label: ?[]const u8,

    pub const json_field_names = .{
        .category = "Category",
        .custom_properties = "CustomProperties",
        .description = "Description",
        .entity_name = "EntityName",
        .is_parent_entity = "IsParentEntity",
        .label = "Label",
    };
};
