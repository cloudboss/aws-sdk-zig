const ConfiguredTableAssociationAnalysisRulePolicy = @import("configured_table_association_analysis_rule_policy.zig").ConfiguredTableAssociationAnalysisRulePolicy;
const ConfiguredTableAssociationAnalysisRuleType = @import("configured_table_association_analysis_rule_type.zig").ConfiguredTableAssociationAnalysisRuleType;

/// An analysis rule for a configured table association. This analysis rule
/// specifies how data from the table can be used within its associated
/// collaboration. In the console, the `ConfiguredTableAssociationAnalysisRule`
/// is referred to as the *collaboration analysis rule*.
pub const ConfiguredTableAssociationAnalysisRule = struct {
    /// The Amazon Resource Name (ARN) of the configured table association.
    configured_table_association_arn: []const u8,

    /// The unique identifier for the configured table association.
    configured_table_association_id: []const u8,

    /// The creation time of the configured table association analysis rule.
    create_time: i64,

    /// The membership identifier for the configured table association analysis
    /// rule.
    membership_identifier: []const u8,

    /// The policy of the configured table association analysis rule.
    policy: ConfiguredTableAssociationAnalysisRulePolicy,

    /// The type of the configured table association analysis rule.
    @"type": ConfiguredTableAssociationAnalysisRuleType,

    /// The update time of the configured table association analysis rule.
    update_time: i64,

    pub const json_field_names = .{
        .configured_table_association_arn = "configuredTableAssociationArn",
        .configured_table_association_id = "configuredTableAssociationId",
        .create_time = "createTime",
        .membership_identifier = "membershipIdentifier",
        .policy = "policy",
        .@"type" = "type",
        .update_time = "updateTime",
    };
};
