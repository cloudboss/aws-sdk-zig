const DataQualityAggregatedMetrics = @import("data_quality_aggregated_metrics.zig").DataQualityAggregatedMetrics;
const DataQualityAnalyzerResult = @import("data_quality_analyzer_result.zig").DataQualityAnalyzerResult;
const DataSource = @import("data_source.zig").DataSource;
const DataQualityObservation = @import("data_quality_observation.zig").DataQualityObservation;
const DataQualityRuleResult = @import("data_quality_rule_result.zig").DataQualityRuleResult;

/// Describes a data quality result.
pub const DataQualityResult = struct {
    /// A summary of `DataQualityAggregatedMetrics` objects showing the total counts
    /// of processed rows and rules, including their pass/fail statistics based on
    /// row-level results.
    aggregated_metrics: ?DataQualityAggregatedMetrics,

    /// A list of `DataQualityAnalyzerResult` objects representing the results for
    /// each analyzer.
    analyzer_results: ?[]const DataQualityAnalyzerResult,

    /// The date and time when this data quality run completed.
    completed_on: ?i64,

    /// The table associated with the data quality result, if any.
    data_source: ?DataSource,

    /// In the context of a job in Glue Studio, each node in the canvas is typically
    /// assigned some sort of name and data quality nodes will have names. In the
    /// case of multiple nodes, the `evaluationContext` can differentiate the nodes.
    evaluation_context: ?[]const u8,

    /// The job name associated with the data quality result, if any.
    job_name: ?[]const u8,

    /// The job run ID associated with the data quality result, if any.
    job_run_id: ?[]const u8,

    /// A list of `DataQualityObservation` objects representing the observations
    /// generated after evaluating the rules and analyzers.
    observations: ?[]const DataQualityObservation,

    /// The Profile ID for the data quality result.
    profile_id: ?[]const u8,

    /// A unique result ID for the data quality result.
    result_id: ?[]const u8,

    /// A list of `DataQualityRuleResult` objects representing the results for each
    /// rule.
    rule_results: ?[]const DataQualityRuleResult,

    /// The unique run ID for the ruleset evaluation for this data quality result.
    ruleset_evaluation_run_id: ?[]const u8,

    /// The name of the ruleset associated with the data quality result.
    ruleset_name: ?[]const u8,

    /// An aggregate data quality score. Represents the ratio of rules that passed
    /// to the total number of rules.
    score: ?f64,

    /// The date and time when this data quality run started.
    started_on: ?i64,

    pub const json_field_names = .{
        .aggregated_metrics = "AggregatedMetrics",
        .analyzer_results = "AnalyzerResults",
        .completed_on = "CompletedOn",
        .data_source = "DataSource",
        .evaluation_context = "EvaluationContext",
        .job_name = "JobName",
        .job_run_id = "JobRunId",
        .observations = "Observations",
        .profile_id = "ProfileId",
        .result_id = "ResultId",
        .rule_results = "RuleResults",
        .ruleset_evaluation_run_id = "RulesetEvaluationRunId",
        .ruleset_name = "RulesetName",
        .score = "Score",
        .started_on = "StartedOn",
    };
};
