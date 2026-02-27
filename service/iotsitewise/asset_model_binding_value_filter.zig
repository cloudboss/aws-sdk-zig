/// A filter used to match data bindings based on a specific asset model. This
/// filter
/// identifies all computation models referencing a particular asset model in
/// their data
/// bindings.
pub const AssetModelBindingValueFilter = struct {
    /// The ID of the asset model to filter data bindings by. Only data bindings
    /// referemncing this
    /// specific asset model are matched.
    asset_model_id: []const u8,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
    };
};
