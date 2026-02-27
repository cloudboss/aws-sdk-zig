/// The asset model property identifer of the input routed from AWS IoT
/// SiteWise.
pub const IotSiteWiseAssetModelPropertyIdentifier = struct {
    /// The ID of the AWS IoT SiteWise asset model.
    asset_model_id: []const u8,

    /// The ID of the AWS IoT SiteWise asset property.
    property_id: []const u8,

    pub const json_field_names = .{
        .asset_model_id = "assetModelId",
        .property_id = "propertyId",
    };
};
