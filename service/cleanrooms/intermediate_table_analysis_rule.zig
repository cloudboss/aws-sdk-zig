const IntermediateTableAnalysisRulePolicy = @import("intermediate_table_analysis_rule_policy.zig").IntermediateTableAnalysisRulePolicy;
const IntermediateTableAnalysisRuleType = @import("intermediate_table_analysis_rule_type.zig").IntermediateTableAnalysisRuleType;

/// Contains the details of an analysis rule for an intermediate table.
pub const IntermediateTableAnalysisRule = struct {
    /// The policy of the analysis rule.
    analysis_rule_policy: IntermediateTableAnalysisRulePolicy,

    /// The type of the analysis rule.
    analysis_rule_type: IntermediateTableAnalysisRuleType,

    /// The time the analysis rule was created.
    create_time: i64,

    /// The Amazon Resource Name (ARN) of the intermediate table associated with
    /// this analysis rule.
    intermediate_table_arn: []const u8,

    /// The unique identifier of the intermediate table associated with this
    /// analysis rule.
    intermediate_table_identifier: []const u8,

    /// The time the analysis rule was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_rule_policy = "analysisRulePolicy",
        .analysis_rule_type = "analysisRuleType",
        .create_time = "createTime",
        .intermediate_table_arn = "intermediateTableArn",
        .intermediate_table_identifier = "intermediateTableIdentifier",
        .update_time = "updateTime",
    };
};
