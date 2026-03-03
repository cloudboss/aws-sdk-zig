const IgnoreNearExpected = @import("ignore_near_expected.zig").IgnoreNearExpected;

/// Configuration for the Random Cut Forest algorithm used for anomaly detection
/// in time-series data.
pub const RandomCutForestConfiguration = struct {
    /// Configuration for ignoring values that are near expected values from above
    /// during anomaly detection.
    ignore_near_expected_from_above: ?IgnoreNearExpected = null,

    /// Configuration for ignoring values that are near expected values from below
    /// during anomaly detection.
    ignore_near_expected_from_below: ?IgnoreNearExpected = null,

    /// The Prometheus query used to retrieve the time-series data for anomaly
    /// detection.
    ///
    /// Random Cut Forest queries must be wrapped by a supported PromQL aggregation
    /// operator. For more information, see [Aggregation
    /// operators](https://prometheus.io/docs/prometheus/latest/querying/operators/#aggregation-operators) on the *Prometheus docs* website.
    ///
    /// **Supported PromQL aggregation operators**: `avg`, `count`, `group`, `max`,
    /// `min`, `quantile`, `stddev`, `stdvar`, and `sum`.
    query: []const u8,

    /// The number of data points sampled from the input stream for the Random Cut
    /// Forest algorithm. The default number is 256 consecutive data points.
    sample_size: i32 = 256,

    /// The number of consecutive data points used to create a shingle for the
    /// Random Cut Forest algorithm. The default number is 8 consecutive data
    /// points.
    shingle_size: i32 = 8,

    pub const json_field_names = .{
        .ignore_near_expected_from_above = "ignoreNearExpectedFromAbove",
        .ignore_near_expected_from_below = "ignoreNearExpectedFromBelow",
        .query = "query",
        .sample_size = "sampleSize",
        .shingle_size = "shingleSize",
    };
};
