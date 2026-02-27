/// Describes the data quality metric value according to the analysis of
/// historical data.
pub const DataQualityMetricValues = struct {
    /// The actual value of the data quality metric.
    actual_value: ?f64,

    /// The expected value of the data quality metric according to the analysis of
    /// historical data.
    expected_value: ?f64,

    /// The lower limit of the data quality metric value according to the analysis
    /// of historical data.
    lower_limit: ?f64,

    /// The upper limit of the data quality metric value according to the analysis
    /// of historical data.
    upper_limit: ?f64,

    pub const json_field_names = .{
        .actual_value = "ActualValue",
        .expected_value = "ExpectedValue",
        .lower_limit = "LowerLimit",
        .upper_limit = "UpperLimit",
    };
};
