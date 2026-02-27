/// A filter used to match data bindings based on a specific asset model
/// property. This filter
/// identifies all computation models that reference a particular property of an
/// asset model in
/// their data bindings.
pub const AssetModelPropertyBindingValueFilter = struct {
    /// The ID of the asset model containing the filter property. This identifies
    /// the specific
    /// asset model that contains the property of interest.
    asset_model_id: []const u8,

    /// The ID of the property within the asset model to filter by. Only data
    /// bindings referencing
    /// this specific property of the specified asset model are matched.
    property_id: []const u8,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .property_id = "propertyId",
    };
};
