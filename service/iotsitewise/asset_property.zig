const PropertyDataType = @import("property_data_type.zig").PropertyDataType;
const PropertyNotification = @import("property_notification.zig").PropertyNotification;
const AssetPropertyPathSegment = @import("asset_property_path_segment.zig").AssetPropertyPathSegment;

/// Contains asset property information.
pub const AssetProperty = struct {
    /// The alias that identifies the property, such as an OPC-UA server data stream
    /// path
    /// (for example, `/company/windfarm/3/turbine/7/temperature`). For more
    /// information, see
    /// [Mapping industrial data streams to asset
    /// properties](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/connect-data-streams.html) in the
    /// *IoT SiteWise User Guide*.
    alias: ?[]const u8 = null,

    /// The data type of the asset property.
    data_type: PropertyDataType,

    /// The data type of the structure for this property. This parameter exists on
    /// properties that
    /// have the `STRUCT` data type.
    data_type_spec: ?[]const u8 = null,

    /// The external ID of the asset property. For more information, see [Using
    /// external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8 = null,

    /// The ID of the asset property.
    id: []const u8,

    /// The name of the property.
    name: []const u8,

    /// The asset property's notification topic and state. For more information, see
    /// [UpdateAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetProperty.html).
    notification: ?PropertyNotification = null,

    /// The structured path to the property from the root of the asset.
    path: ?[]const AssetPropertyPathSegment = null,

    /// The unit (such as `Newtons` or `RPM`) of the asset property.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "alias",
        .data_type = "dataType",
        .data_type_spec = "dataTypeSpec",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
        .notification = "notification",
        .path = "path",
        .unit = "unit",
    };
};
