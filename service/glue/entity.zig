const aws = @import("aws");

/// An entity supported by a given `ConnectionType`.
pub const Entity = struct {
    /// The type of entities that are present in the response. This value depends on
    /// the source connection. For example this is `SObjects` for Salesforce and
    /// `databases` or `schemas` or `tables` for sources like Amazon Redshift.
    category: ?[]const u8 = null,

    /// An optional map of keys which may be returned for an entity by a connector.
    custom_properties: ?[]const aws.map.StringMapEntry = null,

    /// A description of the entity.
    description: ?[]const u8 = null,

    /// The name of the entity.
    entity_name: ?[]const u8 = null,

    /// A Boolean value which helps to determine whether there are sub objects that
    /// can be listed.
    is_parent_entity: ?bool = null,

    /// Label used for the entity.
    label: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "Category",
        .custom_properties = "CustomProperties",
        .description = "Description",
        .entity_name = "EntityName",
        .is_parent_entity = "IsParentEntity",
        .label = "Label",
    };
};
