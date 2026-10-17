const aws = @import("aws");

const DataQualityAggregatedMetrics = @import("data_quality_aggregated_metrics.zig").DataQualityAggregatedMetrics;
const DataQualityAnalyzerResult = @import("data_quality_analyzer_result.zig").DataQualityAnalyzerResult;
const DataSource = @import("data_source.zig").DataSource;
const DataQualityObservation = @import("data_quality_observation.zig").DataQualityObservation;
const DataQualityRuleResult = @import("data_quality_rule_result.zig").DataQualityRuleResult;

/// Describes a data quality result returned by `BatchGetDataQualityResultV2`.
pub const DataQualityResultV2Item = struct {
    /// A summary of `DataQualityAggregatedMetrics` objects showing the total counts
    /// of processed rows and rules, including their pass/fail statistics based on
    /// row-level results.
    aggregated_metrics: ?DataQualityAggregatedMetrics = null,

    /// A list of `DataQualityAnalyzerResult` objects representing the results for
    /// each analyzer.
    analyzer_results: ?[]const DataQualityAnalyzerResult = null,

    /// The table associated with the data quality result, if any.
    data_source: ?DataSource = null,

    /// A map of user-provided descriptors that add contextual metadata and
    /// configuration to the data quality result, such as database name, table name,
    /// team, or environment.
    descriptors: ?[]const aws.map.StringMapEntry = null,

    /// A map of platform-specific identifiers, such as cluster, application,
    /// workgroup, or project IDs, that identify where the data quality evaluation
    /// ran.
    dimensions: ?[]const aws.map.StringMapEntry = null,

    /// The evaluation context for the data quality result. This value identifies a
    /// specific data quality result, or a series of related results, within a run.
    evaluation_context: ?[]const u8 = null,

    /// The date and time when this data quality run completed.
    execution_completed_on: ?i64 = null,

    /// The date and time when this data quality run started.
    execution_started_on: ?i64 = null,

    /// A list of `DataQualityObservation` objects representing the anomaly
    /// detection observations generated after evaluating the rules and analyzers.
    observations: ?[]const DataQualityObservation = null,

    /// A unique result ID for the data quality result.
    result_id: []const u8,

    /// The date and time when this data quality result was published.
    result_published_on: ?i64 = null,

    /// A list of `DataQualityRuleResult` objects representing the results for each
    /// rule.
    rule_results: ?[]const DataQualityRuleResult = null,

    /// The name of the ruleset associated with the data quality result.
    ruleset_name: ?[]const u8 = null,

    /// An aggregate data quality score. Represents the ratio of rules that passed
    /// to the total number of rules.
    score: ?f64 = null,

    /// A map of tags associated with the data quality result.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregated_metrics = "AggregatedMetrics",
        .analyzer_results = "AnalyzerResults",
        .data_source = "DataSource",
        .descriptors = "Descriptors",
        .dimensions = "Dimensions",
        .evaluation_context = "EvaluationContext",
        .execution_completed_on = "ExecutionCompletedOn",
        .execution_started_on = "ExecutionStartedOn",
        .observations = "Observations",
        .result_id = "ResultId",
        .result_published_on = "ResultPublishedOn",
        .rule_results = "RuleResults",
        .ruleset_name = "RulesetName",
        .score = "Score",
        .tags = "Tags",
    };
};
