/// Filter by asset model.
pub const FilterByAssetModel = struct {
    /// The external-Id property of an asset model.
    asset_model_external_id: ?[]const u8,

    /// The asset model Id.
    asset_model_id: ?[]const u8,

    /// Bolean to include assets.
    include_assets: ?bool,

    /// Include asset offspring. [need desc.]
    include_offspring: ?bool,

    pub const json_field_names = .{
        .asset_model_external_id = "assetModelExternalId",
        .asset_model_id = "assetModelId",
        .include_assets = "includeAssets",
        .include_offspring = "includeOffspring",
    };
};
