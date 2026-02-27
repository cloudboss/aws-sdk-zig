const AssetPropertyValue = @import("asset_property_value.zig").AssetPropertyValue;

/// Contains a list of value updates for an asset property in the list of asset
/// entries
/// consumed by the
/// [BatchPutAssetPropertyValue](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchPutAssetPropertyValue.html) API
/// operation.
pub const PutAssetPropertyValueEntry = struct {
    /// The ID of the asset to update.
    asset_id: ?[]const u8,

    /// The user specified ID for the entry. You can use this ID to identify which
    /// entries
    /// failed.
    entry_id: []const u8,

    /// The alias that identifies the property, such as an OPC-UA server data stream
    /// path
    /// (for example, `/company/windfarm/3/turbine/7/temperature`). For more
    /// information, see
    /// [Mapping industrial data streams to asset
    /// properties](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/connect-data-streams.html) in the
    /// *IoT SiteWise User Guide*.
    property_alias: ?[]const u8,

    /// The ID of the asset property for this entry.
    property_id: ?[]const u8,

    /// The list of property values to upload. You can specify up to 10
    /// `propertyValues` array elements.
    property_values: []const AssetPropertyValue,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .entry_id = "entryId",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
        .property_values = "propertyValues",
    };
};
