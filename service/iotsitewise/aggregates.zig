/// Contains the (pre-calculated) aggregate values for an asset property.
pub const Aggregates = struct {
    /// The average (mean) value of the time series over a time interval window.
    average: ?f64 = null,

    /// The count of data points in the time series over a time interval window.
    count: ?f64 = null,

    /// The maximum value of the time series over a time interval window.
    maximum: ?f64 = null,

    /// The minimum value of the time series over a time interval window.
    minimum: ?f64 = null,

    /// The standard deviation of the time series over a time interval window.
    standard_deviation: ?f64 = null,

    /// The sum of the time series over a time interval window.
    sum: ?f64 = null,

    pub const json_field_names = .{
        .average = "average",
        .count = "count",
        .maximum = "maximum",
        .minimum = "minimum",
        .standard_deviation = "standardDeviation",
        .sum = "sum",
    };
};
