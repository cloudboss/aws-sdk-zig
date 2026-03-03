const Row = @import("row.zig").Row;
const TimeSeriesDataPoint = @import("time_series_data_point.zig").TimeSeriesDataPoint;

/// Datum represents a single data point in a query result.
pub const Datum = struct {
    /// Indicates if the data point is an array.
    array_value: ?[]const Datum = null,

    /// Indicates if the data point is null.
    null_value: ?bool = null,

    /// Indicates if the data point is a row.
    row_value: ?*Row = null,

    /// Indicates if the data point is a scalar value such as integer, string,
    /// double, or
    /// Boolean.
    scalar_value: ?[]const u8 = null,

    /// Indicates if the data point is a timeseries data type.
    time_series_value: ?[]const TimeSeriesDataPoint = null,

    pub const json_field_names = .{
        .array_value = "ArrayValue",
        .null_value = "NullValue",
        .row_value = "RowValue",
        .scalar_value = "ScalarValue",
        .time_series_value = "TimeSeriesValue",
    };
};
