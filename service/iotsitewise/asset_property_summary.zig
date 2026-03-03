const PropertyNotification = @import("property_notification.zig").PropertyNotification;
const AssetPropertyPathSegment = @import("asset_property_path_segment.zig").AssetPropertyPathSegment;

/// Contains a summary of a property associated with an asset.
pub const AssetPropertySummary = struct {
    /// The alias that identifies the property, such as an OPC-UA server data stream
    /// path
    /// (for example, `/company/windfarm/3/turbine/7/temperature`). For more
    /// information, see
    /// [Mapping industrial data streams to asset
    /// properties](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/connect-data-streams.html) in the
    /// *IoT SiteWise User Guide*.
    alias: ?[]const u8 = null,

    /// The ID of the composite model that contains the asset property.
    asset_composite_model_id: ?[]const u8 = null,

    /// The external ID of the property. For more information, see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8 = null,

    /// The ID of the property.
    id: []const u8,

    notification: ?PropertyNotification = null,

    /// The structured path to the property from the root of the asset.
    path: ?[]const AssetPropertyPathSegment = null,

    /// The unit of measure (such as Newtons or RPM) of the asset property.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "alias",
        .asset_composite_model_id = "assetCompositeModelId",
        .external_id = "externalId",
        .id = "id",
        .notification = "notification",
        .path = "path",
        .unit = "unit",
    };
};
