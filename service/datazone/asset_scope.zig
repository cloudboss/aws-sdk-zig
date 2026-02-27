/// The asset scope.
pub const AssetScope = struct {
    /// The asset ID of the asset scope.
    asset_id: []const u8,

    /// The error message of the asset scope.
    error_message: ?[]const u8,

    /// The filter IDs of the asset scope.
    filter_ids: []const []const u8,

    /// The status of the asset scope.
    status: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .error_message = "errorMessage",
        .filter_ids = "filterIds",
        .status = "status",
    };
};
