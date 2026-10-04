const DQCompositeRuleEvaluationMethod = @import("dq_composite_rule_evaluation_method.zig").DQCompositeRuleEvaluationMethod;
const DataQualityRuleResultsOptions = @import("data_quality_rule_results_options.zig").DataQualityRuleResultsOptions;
const ObservationMode = @import("observation_mode.zig").ObservationMode;
const ObservationResultsOptions = @import("observation_results_options.zig").ObservationResultsOptions;
const ObservationConfiguration = @import("observation_configuration.zig").ObservationConfiguration;
const ProfilingResultsOptions = @import("profiling_results_options.zig").ProfilingResultsOptions;
const RowLevelResultsOptions = @import("row_level_results_options.zig").RowLevelResultsOptions;

/// Additional run options you can specify for an evaluation run.
pub const DataQualityEvaluationRunAdditionalRunOptions = struct {
    /// Whether or not to enable CloudWatch metrics.
    cloud_watch_metrics_enabled: ?bool = null,

    /// Set the evaluation method for composite rules in the ruleset to ROW/COLUMN
    composite_rule_evaluation_method: ?DQCompositeRuleEvaluationMethod = null,

    /// A custom prefix for the CloudWatch log group names. When specified,
    /// evaluation run logs are written to `/error` and `/output` instead of the
    /// default `/aws-glue/data-quality/error` and `/aws-glue/data-quality/output`
    /// log groups.
    custom_log_group_prefix: ?[]const u8 = null,

    /// The configuration for writing rule results to a Glue Data Catalog table.
    data_quality_rule_results: ?DataQualityRuleResultsOptions = null,

    /// The observation mode for the evaluation run. Specifies how anomaly detection
    /// bounds are calculated.
    observation_mode: ?ObservationMode = null,

    /// The configuration for writing observation results to a Glue Data Catalog
    /// table.
    observation_results: ?ObservationResultsOptions = null,

    /// The scope of the observation for the evaluation run. Specifies whether
    /// anomaly detection is enabled or disabled.
    observation_scope: ?ObservationConfiguration = null,

    /// The configuration for writing profiling results to a Glue Data Catalog
    /// table.
    profiling_results: ?ProfilingResultsOptions = null,

    /// Prefix for Amazon S3 to store results.
    results_s3_prefix: ?[]const u8 = null,

    /// The configuration for writing row-level evaluation results to a Glue Data
    /// Catalog table.
    row_level_results: ?RowLevelResultsOptions = null,

    pub const json_field_names = .{
        .cloud_watch_metrics_enabled = "CloudWatchMetricsEnabled",
        .composite_rule_evaluation_method = "CompositeRuleEvaluationMethod",
        .custom_log_group_prefix = "CustomLogGroupPrefix",
        .data_quality_rule_results = "DataQualityRuleResults",
        .observation_mode = "ObservationMode",
        .observation_results = "ObservationResults",
        .observation_scope = "ObservationScope",
        .profiling_results = "ProfilingResults",
        .results_s3_prefix = "ResultsS3Prefix",
        .row_level_results = "RowLevelResults",
    };
};
