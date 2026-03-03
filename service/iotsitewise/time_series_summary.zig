const PropertyDataType = @import("property_data_type.zig").PropertyDataType;

/// Contains a summary of a time series (data stream).
pub const TimeSeriesSummary = struct {
    /// The alias that identifies the time series.
    alias: ?[]const u8 = null,

    /// The ID of the asset in which the asset property was created.
    asset_id: ?[]const u8 = null,

    /// The data type of the time series.
    ///
    /// If you specify `STRUCT`, you must also specify `dataTypeSpec` to identify
    /// the type of the structure for this time series.
    data_type: PropertyDataType,

    /// The data type of the structure for this time series. This parameter is
    /// required for time series
    /// that have the `STRUCT` data type.
    ///
    /// The options for this parameter depend on the type of the composite model
    /// in which you created the asset property that is associated with your time
    /// series.
    /// Use `AWS/ALARM_STATE` for alarm state in alarm composite models.
    data_type_spec: ?[]const u8 = null,

    /// The ID of the asset property, in UUID format.
    property_id: ?[]const u8 = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the time series, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:time-series/${TimeSeriesId}`
    time_series_arn: []const u8,

    /// The date that the time series was created, in Unix epoch time.
    time_series_creation_date: i64,

    /// The ID of the time series.
    time_series_id: []const u8,

    /// The date that the time series was last updated, in Unix epoch time.
    time_series_last_update_date: i64,

    pub const json_field_names = .{
        .alias = "alias",
        .asset_id = "assetId",
        .data_type = "dataType",
        .data_type_spec = "dataTypeSpec",
        .property_id = "propertyId",
        .time_series_arn = "timeSeriesArn",
        .time_series_creation_date = "timeSeriesCreationDate",
        .time_series_id = "timeSeriesId",
        .time_series_last_update_date = "timeSeriesLastUpdateDate",
    };
};
