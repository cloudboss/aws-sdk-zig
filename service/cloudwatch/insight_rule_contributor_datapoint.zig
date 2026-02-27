/// One data point related to one contributor.
///
/// For more information, see
/// [GetInsightRuleReport](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetInsightRuleReport.html) and [InsightRuleContributor](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_InsightRuleContributor.html).
pub const InsightRuleContributorDatapoint = struct {
    /// The approximate value that this contributor added during this timestamp.
    approximate_value: f64,

    /// The timestamp of the data point.
    timestamp: i64,

    pub const json_field_names = .{
        .approximate_value = "ApproximateValue",
        .timestamp = "Timestamp",
    };
};
