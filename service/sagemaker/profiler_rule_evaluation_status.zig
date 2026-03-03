const RuleEvaluationStatus = @import("rule_evaluation_status.zig").RuleEvaluationStatus;

/// Information about the status of the rule evaluation.
pub const ProfilerRuleEvaluationStatus = struct {
    /// Timestamp when the rule evaluation status was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the rule configuration.
    rule_configuration_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the rule evaluation job.
    rule_evaluation_job_arn: ?[]const u8 = null,

    /// Status of the rule evaluation.
    rule_evaluation_status: ?RuleEvaluationStatus = null,

    /// Details from the rule evaluation.
    status_details: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_modified_time = "LastModifiedTime",
        .rule_configuration_name = "RuleConfigurationName",
        .rule_evaluation_job_arn = "RuleEvaluationJobArn",
        .rule_evaluation_status = "RuleEvaluationStatus",
        .status_details = "StatusDetails",
    };
};
