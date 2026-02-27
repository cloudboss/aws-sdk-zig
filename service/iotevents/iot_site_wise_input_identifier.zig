const IotSiteWiseAssetModelPropertyIdentifier = @import("iot_site_wise_asset_model_property_identifier.zig").IotSiteWiseAssetModelPropertyIdentifier;

/// The identifer of the input routed from AWS IoT SiteWise.
pub const IotSiteWiseInputIdentifier = struct {
    /// The identifier of the AWS IoT SiteWise asset model property.
    iot_site_wise_asset_model_property_identifier: ?IotSiteWiseAssetModelPropertyIdentifier,

    pub const json_field_names = .{
        .iot_site_wise_asset_model_property_identifier = "iotSiteWiseAssetModelPropertyIdentifier",
    };
};
