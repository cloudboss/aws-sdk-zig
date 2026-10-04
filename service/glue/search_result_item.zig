/// A single search result item representing a matched asset.
pub const SearchResultItem = struct {
    /// The description of the matched asset.
    asset_description: ?[]const u8 = null,

    /// The name of the matched asset.
    asset_name: ?[]const u8 = null,

    /// The identifier of the asset type for the matched asset.
    asset_type_id: ?[]const u8 = null,

    /// The unique identifier of the matched asset.
    id: ?[]const u8 = null,

    /// The timestamp at which the matched asset was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .asset_description = "AssetDescription",
        .asset_name = "AssetName",
        .asset_type_id = "AssetTypeId",
        .id = "Id",
        .updated_at = "UpdatedAt",
    };
};
