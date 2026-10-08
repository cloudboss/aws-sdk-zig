const ConfiguredTableAnalysisRulePolicy = @import("configured_table_analysis_rule_policy.zig").ConfiguredTableAnalysisRulePolicy;
const ConfiguredTableAnalysisRuleType = @import("configured_table_analysis_rule_type.zig").ConfiguredTableAnalysisRuleType;

/// A configured table analysis rule, which limits how data for this table can
/// be used.
pub const ConfiguredTableAnalysisRule = struct {
    /// The unique ARN for the configured table.
    configured_table_arn: []const u8,

    /// The unique ID for the configured table.
    configured_table_id: []const u8,

    /// The time the configured table analysis rule was created.
    create_time: i64,

    /// The policy that controls SQL query rules.
    policy: ConfiguredTableAnalysisRulePolicy,

    /// The type of configured table analysis rule.
    type: ConfiguredTableAnalysisRuleType,

    /// The time the configured table analysis rule was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .configured_table_arn = "configuredTableArn",
        .configured_table_id = "configuredTableId",
        .create_time = "createTime",
        .policy = "policy",
        .type = "type",
        .update_time = "updateTime",
    };
};
