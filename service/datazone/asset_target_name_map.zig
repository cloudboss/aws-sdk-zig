/// The name map for assets.
pub const AssetTargetNameMap = struct {
    /// The identifier of the inventory asset.
    asset_id: []const u8,

    /// The target name in the asset target name map.
    target_name: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .target_name = "targetName",
    };
};
