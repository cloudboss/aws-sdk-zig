/// Contains information about an `assetModelProperty` binding value.
pub const AssetModelPropertyBindingValue = struct {
    /// The ID of the asset model, in UUID format.
    asset_model_id: []const u8,

    /// The ID of the asset model property used in data binding value.
    property_id: []const u8,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .property_id = "propertyId",
    };
};
