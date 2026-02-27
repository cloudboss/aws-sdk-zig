/// Represents a data binding value referencing a specific asset property. It's
/// used to bind
/// computation model variables to actual asset property values for processing.
pub const AssetPropertyBindingValue = struct {
    /// The ID of the asset containing the property. This identifies the specific
    /// asset instance's
    /// property value used in the computation model.
    asset_id: []const u8,

    /// The ID of the property within the asset. This identifies the specific
    /// property's value
    /// used in the computation model.
    property_id: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .property_id = "propertyId",
    };
};
