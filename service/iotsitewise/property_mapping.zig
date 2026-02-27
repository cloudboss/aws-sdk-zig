/// Maps a property from an interface asset model to a property in the asset
/// model where the
/// interface is applied.
pub const PropertyMapping = struct {
    /// The ID of the property in the asset model where the interface is applied.
    asset_model_property_id: []const u8,

    /// The ID of the property in the interface asset model.
    interface_asset_model_property_id: []const u8,

    pub const json_field_names = .{
        .asset_model_property_id = "assetModelPropertyId",
        .interface_asset_model_property_id = "interfaceAssetModelPropertyId",
    };
};
