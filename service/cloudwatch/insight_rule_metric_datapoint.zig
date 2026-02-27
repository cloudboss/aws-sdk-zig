/// One data point from the metric time series returned in a Contributor
/// Insights rule
/// report.
///
/// For more information, see
/// [GetInsightRuleReport](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetInsightRuleReport.html).
pub const InsightRuleMetricDatapoint = struct {
    /// The average value from all contributors during the time period represented
    /// by that
    /// data point.
    ///
    /// This statistic is returned only if you included it in the `Metrics` array
    /// in your request.
    average: ?f64,

    /// The maximum value provided by one contributor during this timestamp. Each
    /// timestamp is
    /// evaluated separately, so the identity of the max contributor could be
    /// different for each
    /// timestamp.
    ///
    /// This statistic is returned only if you included it in the `Metrics` array
    /// in your request.
    max_contributor_value: ?f64,

    /// The maximum value from a single occurence from a single contributor during
    /// the time
    /// period represented by that data point.
    ///
    /// This statistic is returned only if you included it in the `Metrics` array
    /// in your request.
    maximum: ?f64,

    /// The minimum value from a single contributor during the time period
    /// represented by that
    /// data point.
    ///
    /// This statistic is returned only if you included it in the `Metrics` array
    /// in your request.
    minimum: ?f64,

    /// The number of occurrences that matched the rule during this data point.
    ///
    /// This statistic is returned only if you included it in the `Metrics` array
    /// in your request.
    sample_count: ?f64,

    /// The sum of the values from all contributors during the time period
    /// represented by that
    /// data point.
    ///
    /// This statistic is returned only if you included it in the `Metrics` array
    /// in your request.
    sum: ?f64,

    /// The timestamp of the data point.
    timestamp: i64,

    /// The number of unique contributors who published data during this timestamp.
    ///
    /// This statistic is returned only if you included it in the `Metrics` array
    /// in your request.
    unique_contributors: ?f64,

    pub const json_field_names = .{
        .average = "Average",
        .max_contributor_value = "MaxContributorValue",
        .maximum = "Maximum",
        .minimum = "Minimum",
        .sample_count = "SampleCount",
        .sum = "Sum",
        .timestamp = "Timestamp",
        .unique_contributors = "UniqueContributors",
    };
};
