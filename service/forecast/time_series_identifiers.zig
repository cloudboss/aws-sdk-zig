const DataSource = @import("data_source.zig").DataSource;
const Schema = @import("schema.zig").Schema;

/// Details about the import file that contains the time series for which you
/// want to create forecasts.
pub const TimeSeriesIdentifiers = struct {
    data_source: ?DataSource,

    /// The format of the data, either CSV or PARQUET.
    format: ?[]const u8,

    schema: ?Schema,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .format = "Format",
        .schema = "Schema",
    };
};
