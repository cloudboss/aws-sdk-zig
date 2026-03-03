/// Options to configure how your data quality evaluation results are published.
pub const DQResultsPublishingOptions = struct {
    /// Enable metrics for your data quality results.
    cloud_watch_metrics_enabled: ?bool = null,

    /// The context of the evaluation.
    evaluation_context: ?[]const u8 = null,

    /// Enable publishing for your data quality results.
    results_publishing_enabled: ?bool = null,

    /// The Amazon S3 prefix prepended to the results.
    results_s3_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_metrics_enabled = "CloudWatchMetricsEnabled",
        .evaluation_context = "EvaluationContext",
        .results_publishing_enabled = "ResultsPublishingEnabled",
        .results_s3_prefix = "ResultsS3Prefix",
    };
};
