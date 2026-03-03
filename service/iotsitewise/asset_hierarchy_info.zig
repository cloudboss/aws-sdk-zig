/// Contains information about a parent asset and a child asset that are related
/// through an
/// asset hierarchy.
pub const AssetHierarchyInfo = struct {
    /// The ID of the child asset in this asset relationship.
    child_asset_id: ?[]const u8 = null,

    /// The ID of the parent asset in this asset relationship.
    parent_asset_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .child_asset_id = "childAssetId",
        .parent_asset_id = "parentAssetId",
    };
};
