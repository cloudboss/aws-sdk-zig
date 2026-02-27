/// An object that contains entity ID and the catalog in which the entity is
/// present.
pub const EntityRequest = struct {
    /// The name of the catalog the entity is present in. The only value at this
    /// time is
    /// `AWSMarketplace`.
    catalog: []const u8,

    /// The ID of the entity.
    entity_id: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .entity_id = "EntityId",
    };
};
