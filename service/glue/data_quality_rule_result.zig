const aws = @import("aws");

const DataQualityRuleResultStatus = @import("data_quality_rule_result_status.zig").DataQualityRuleResultStatus;

/// Describes the result of the evaluation of a data quality rule.
pub const DataQualityRuleResult = struct {
    /// A description of the data quality rule.
    description: ?[]const u8 = null,

    /// A map of metrics associated with the evaluation of the rule.
    evaluated_metrics: ?[]const aws.map.MapEntry(f64) = null,

    /// The evaluated rule.
    evaluated_rule: ?[]const u8 = null,

    /// An evaluation message.
    evaluation_message: ?[]const u8 = null,

    /// A map containing labels assigned to the data quality rule.
    labels: ?[]const aws.map.StringMapEntry = null,

    /// The name of the data quality rule.
    name: ?[]const u8 = null,

    /// A pass or fail status for the rule.
    result: ?DataQualityRuleResultStatus = null,

    /// A map containing metrics associated with the evaluation of the rule based on
    /// row-level results.
    rule_metrics: ?[]const aws.map.MapEntry(f64) = null,

    pub const json_field_names = .{
        .description = "Description",
        .evaluated_metrics = "EvaluatedMetrics",
        .evaluated_rule = "EvaluatedRule",
        .evaluation_message = "EvaluationMessage",
        .labels = "Labels",
        .name = "Name",
        .result = "Result",
        .rule_metrics = "RuleMetrics",
    };
};
