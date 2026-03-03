/// The listing of the asset in a data product.
pub const AssetInDataProductListingItem = struct {
    /// The entity ID of the listing of the asset in a data product.
    entity_id: ?[]const u8 = null,

    /// The entity revision of the listing of the asset in a data product.
    entity_revision: ?[]const u8 = null,

    /// The entity type of the listing of the asset in a data product.
    entity_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_id = "entityId",
        .entity_revision = "entityRevision",
        .entity_type = "entityType",
    };
};
