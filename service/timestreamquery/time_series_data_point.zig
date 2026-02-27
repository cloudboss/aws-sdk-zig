const Datum = @import("datum.zig").Datum;

/// The timeseries data type represents the values of a measure over time. A
/// time series
/// is an array of rows of timestamps and measure values, with rows sorted in
/// ascending
/// order of time. A TimeSeriesDataPoint is a single data point in the time
/// series. It
/// represents a tuple of (time, measure value) in a time series.
pub const TimeSeriesDataPoint = struct {
    /// The timestamp when the measure value was collected.
    time: []const u8,

    /// The measure value for the data point.
    value: ?*Datum = null,

    pub const json_field_names = .{
        .time = "Time",
        .value = "Value",
    };
};
