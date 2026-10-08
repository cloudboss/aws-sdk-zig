/// Summary of an asset type, including its identifier and description.
pub const AssetTypeSummary = struct {
    /// The asset type identifier
    asset_type: []const u8,

    /// A description of the asset type
    description: []const u8,

    pub const json_field_names = .{
        .asset_type = "assetType",
        .description = "description",
    };
};
