/// Contains information for an asset property value entry that is associated
/// with the
/// [BatchGetAssetPropertyValue](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyValue.html) API.
///
/// To identify an asset property, you must specify one of the following:
///
/// * The `assetId` and `propertyId` of an asset property.
///
/// * A `propertyAlias`, which is a data stream alias (for example,
/// `/company/windfarm/3/turbine/7/temperature`). To define an asset property's
/// alias, see
/// [UpdateAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetProperty.html).
pub const BatchGetAssetPropertyValueEntry = struct {
    /// The ID of the asset in which the asset property was created.
    asset_id: ?[]const u8,

    /// The ID of the entry.
    entry_id: []const u8,

    /// The alias that identifies the property, such as an OPC-UA server data stream
    /// path
    /// (for example, `/company/windfarm/3/turbine/7/temperature`). For more
    /// information, see
    /// [Mapping industrial data streams to asset
    /// properties](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/connect-data-streams.html) in the
    /// *IoT SiteWise User Guide*.
    property_alias: ?[]const u8,

    /// The ID of the asset property, in UUID format.
    property_id: ?[]const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .entry_id = "entryId",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
    };
};
