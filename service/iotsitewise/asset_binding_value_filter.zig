/// A filter used to match data bindings based on a specific asset. This filter
/// identifies all
/// computation models referencing a particular asset in their data bindings.
pub const AssetBindingValueFilter = struct {
    /// The ID of the asset to filter data bindings by. Only data bindings
    /// referencing this
    /// specific asset are matched.
    asset_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
    };
};
