const ColumnInfo = @import("column_info.zig").ColumnInfo;
const ScalarType = @import("scalar_type.zig").ScalarType;

/// Contains the data type of a column in a query result set. The data type can
/// be scalar
/// or complex. The supported scalar data types are integers, Boolean, string,
/// double,
/// timestamp, date, time, and intervals. The supported complex data types are
/// arrays, rows,
/// and timeseries.
pub const Type = struct {
    /// Indicates if the column is an array.
    array_column_info: ?*ColumnInfo = null,

    /// Indicates if the column is a row.
    row_column_info: ?[]const ColumnInfo,

    /// Indicates if the column is of type string, integer, Boolean, double,
    /// timestamp, date,
    /// time. For more information, see [Supported data
    /// types](https://docs.aws.amazon.com/timestream/latest/developerguide/supported-data-types.html).
    scalar_type: ?ScalarType,

    /// Indicates if the column is a timeseries data type.
    time_series_measure_value_column_info: ?*ColumnInfo = null,

    pub const json_field_names = .{
        .array_column_info = "ArrayColumnInfo",
        .row_column_info = "RowColumnInfo",
        .scalar_type = "ScalarType",
        .time_series_measure_value_column_info = "TimeSeriesMeasureValueColumnInfo",
    };
};
