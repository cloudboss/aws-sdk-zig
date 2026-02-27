/// Maps a hierarchy from an interface asset model to a hierarchy in the asset
/// model where the
/// interface is applied.
pub const HierarchyMapping = struct {
    /// The ID of the hierarchy in the asset model where the interface is applied.
    asset_model_hierarchy_id: []const u8,

    /// The ID of the hierarchy in the interface asset model.
    interface_asset_model_hierarchy_id: []const u8,

    pub const json_field_names = .{
        .asset_model_hierarchy_id = "assetModelHierarchyId",
        .interface_asset_model_hierarchy_id = "interfaceAssetModelHierarchyId",
    };
};
