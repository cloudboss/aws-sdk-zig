const ConfiguredTableAssociationAnalysisRulePolicy = @import("configured_table_association_analysis_rule_policy.zig").ConfiguredTableAssociationAnalysisRulePolicy;
const ConsolidatedPolicy = @import("consolidated_policy.zig").ConsolidatedPolicy;
const AnalysisRulePolicy = @import("analysis_rule_policy.zig").AnalysisRulePolicy;
const AnalysisRuleType = @import("analysis_rule_type.zig").AnalysisRuleType;

/// A specification about how data from the configured table can be used in a
/// query.
pub const AnalysisRule = struct {
    /// The unique ID for the associated collaboration.
    collaboration_id: []const u8,

    collaboration_policy: ?ConfiguredTableAssociationAnalysisRulePolicy,

    /// The consolidated policy for the analysis rule.
    consolidated_policy: ?ConsolidatedPolicy,

    /// The time the analysis rule was created.
    create_time: i64,

    /// The name for the analysis rule.
    name: []const u8,

    /// A policy that describes the associated data usage limitations.
    policy: AnalysisRulePolicy,

    /// The type of analysis rule.
    @"type": AnalysisRuleType,

    /// The time the analysis rule was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .collaboration_id = "collaborationId",
        .collaboration_policy = "collaborationPolicy",
        .consolidated_policy = "consolidatedPolicy",
        .create_time = "createTime",
        .name = "name",
        .policy = "policy",
        .@"type" = "type",
        .update_time = "updateTime",
    };
};
