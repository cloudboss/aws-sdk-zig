/// The accepted asset scope.
pub const AcceptedAssetScope = struct {
    /// The asset ID of the accepted asset scope.
    asset_id: []const u8,

    /// The filter IDs of the accepted asset scope.
    filter_ids: []const []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .filter_ids = "filterIds",
    };
};
