/// A filter used to match data bindings based on a specific asset property.
/// This filter helps
/// identify all computation models referencing a particular property of an
/// asset in their data
/// bindings.
pub const AssetPropertyBindingValueFilter = struct {
    /// The ID of the asset containing the property to filter by. This identifies
    /// the specific
    /// asset instance containing the property of interest.
    asset_id: []const u8,

    /// The ID of the property within the asset to filter by. Only data bindings
    /// referencing this
    /// specific property of the specified asset are matched.
    property_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .property_id = "propertyId",
    };
};
