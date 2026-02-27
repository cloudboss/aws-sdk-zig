const S3Config = @import("s3_config.zig").S3Config;
const Schema = @import("schema.zig").Schema;

/// A replacement dataset is a modified version of the baseline related time
/// series that contains only the values
/// that you want to include in a what-if forecast. The replacement dataset must
/// contain the forecast dimensions and
/// item identifiers in the baseline related time series as well as at least 1
/// changed time series. This dataset is
/// merged with the baseline related time series to create a transformed dataset
/// that is used for the what-if
/// forecast.
pub const TimeSeriesReplacementsDataSource = struct {
    /// The format of the replacement data, CSV or PARQUET.
    format: ?[]const u8,

    s3_config: S3Config,

    schema: Schema,

    /// The timestamp format of the replacement data.
    timestamp_format: ?[]const u8,

    pub const json_field_names = .{
        .format = "Format",
        .s3_config = "S3Config",
        .schema = "Schema",
        .timestamp_format = "TimestampFormat",
    };
};
