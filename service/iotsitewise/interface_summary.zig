/// Contains summary information about an interface that a property belongs to.
pub const InterfaceSummary = struct {
    /// The ID of the interface asset model that contains this property.
    interface_asset_model_id: []const u8,

    /// The ID of the property in the interface asset model that corresponds to this
    /// property.
    interface_asset_model_property_id: []const u8,

    pub const json_field_names = .{
        .interface_asset_model_id = "interfaceAssetModelId",
        .interface_asset_model_property_id = "interfaceAssetModelPropertyId",
    };
};
