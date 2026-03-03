/// Filter by asset. [TwinMaker asset]
pub const FilterByAsset = struct {
    /// The external-Id property of an asset.
    asset_external_id: ?[]const u8 = null,

    /// Filter by asset Id.
    asset_id: ?[]const u8 = null,

    /// Boolean to include the asset model.
    include_asset_model: ?bool = null,

    /// Includes sub-assets.[need description hekp for this]
    include_offspring: ?bool = null,

    pub const json_field_names = .{
        .asset_external_id = "assetExternalId",
        .asset_id = "assetId",
        .include_asset_model = "includeAssetModel",
        .include_offspring = "includeOffspring",
    };
};
