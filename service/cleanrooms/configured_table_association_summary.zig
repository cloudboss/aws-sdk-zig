const ConfiguredTableAssociationAnalysisRuleType = @import("configured_table_association_analysis_rule_type.zig").ConfiguredTableAssociationAnalysisRuleType;

/// The configured table association summary for the objects listed by the
/// request.
pub const ConfiguredTableAssociationSummary = struct {
    /// The analysis rule types that are associated with the configured table
    /// associations in this summary.
    analysis_rule_types: ?[]const ConfiguredTableAssociationAnalysisRuleType = null,

    /// The unique ARN for the configured table association.
    arn: []const u8,

    /// The unique configured table ID that this configured table association refers
    /// to.
    configured_table_id: []const u8,

    /// The time the configured table association was created.
    create_time: i64,

    /// The unique ID for the configured table association.
    id: []const u8,

    /// The unique ARN for the membership that the configured table association
    /// belongs to.
    membership_arn: []const u8,

    /// The unique ID for the membership that the configured table association
    /// belongs to.
    membership_id: []const u8,

    /// The name of the configured table association. The table is identified by
    /// this name when running Protected Queries against the underlying data.
    name: []const u8,

    /// The time the configured table association was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_rule_types = "analysisRuleTypes",
        .arn = "arn",
        .configured_table_id = "configuredTableId",
        .create_time = "createTime",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .update_time = "updateTime",
    };
};
