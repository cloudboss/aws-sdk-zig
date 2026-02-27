const Quality = @import("quality.zig").Quality;
const TimeOrdering = @import("time_ordering.zig").TimeOrdering;

/// Contains information for an asset property historical value entry that is
/// associated with
/// the
/// [BatchGetAssetPropertyValueHistory](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_BatchGetAssetPropertyValue.html) API.
///
/// To identify an asset property, you must specify one of the following:
///
/// * The `assetId` and `propertyId` of an asset property.
///
/// * A `propertyAlias`, which is a data stream alias (for example,
/// `/company/windfarm/3/turbine/7/temperature`). To define an asset property's
/// alias, see
/// [UpdateAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetProperty.html).
pub const BatchGetAssetPropertyValueHistoryEntry = struct {
    /// The ID of the asset in which the asset property was created.
    asset_id: ?[]const u8,

    /// The inclusive end of the range from which to query historical data,
    /// expressed in seconds in Unix epoch time.
    end_date: ?i64,

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

    /// The quality by which to filter asset data.
    qualities: ?[]const Quality,

    /// The exclusive start of the range from which to query historical data,
    /// expressed in seconds in Unix epoch time.
    start_date: ?i64,

    /// The chronological sorting order of the requested information.
    ///
    /// Default: `ASCENDING`
    time_ordering: ?TimeOrdering,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .end_date = "endDate",
        .entry_id = "entryId",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
        .qualities = "qualities",
        .start_date = "startDate",
        .time_ordering = "timeOrdering",
    };
};
