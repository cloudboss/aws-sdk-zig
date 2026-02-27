/// A map of key-value pairs for all supported statistics. For issues with
/// missing or unexpected values for this API,
/// consult [
/// Fleet indexing troubleshooting
/// guide](https://docs.aws.amazon.com/iot/latest/developerguide/fleet-indexing-troubleshooting.html).
pub const Statistics = struct {
    /// The average of the aggregated field values.
    average: ?f64,

    /// The count of things that match the query string criteria and contain a valid
    /// aggregation field value.
    count: i32 = 0,

    /// The maximum aggregated field value.
    maximum: ?f64,

    /// The minimum aggregated field value.
    minimum: ?f64,

    /// The standard deviation of the aggregated field values.
    std_deviation: ?f64,

    /// The sum of the aggregated field values.
    sum: ?f64,

    /// The sum of the squares of the aggregated field values.
    sum_of_squares: ?f64,

    /// The variance of the aggregated field values.
    variance: ?f64,

    pub const json_field_names = .{
        .average = "average",
        .count = "count",
        .maximum = "maximum",
        .minimum = "minimum",
        .std_deviation = "stdDeviation",
        .sum = "sum",
        .sum_of_squares = "sumOfSquares",
        .variance = "variance",
    };
};
