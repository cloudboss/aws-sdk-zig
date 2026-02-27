const ConfiguredTableAssociationAnalysisRuleType = @import("configured_table_association_analysis_rule_type.zig").ConfiguredTableAssociationAnalysisRuleType;

/// A configured table association links a configured table to a collaboration.
pub const ConfiguredTableAssociation = struct {
    /// The analysis rule types for the configured table association.
    analysis_rule_types: ?[]const ConfiguredTableAssociationAnalysisRuleType,

    /// The unique ARN for the configured table association.
    arn: []const u8,

    /// The unique ARN for the configured table that the association refers to.
    configured_table_arn: []const u8,

    /// The unique ID for the configured table that the association refers to.
    configured_table_id: []const u8,

    /// The time the configured table association was created.
    create_time: i64,

    /// A description of the configured table association.
    description: ?[]const u8,

    /// The unique ID for the configured table association.
    id: []const u8,

    /// The unique ARN for the membership this configured table association belongs
    /// to.
    membership_arn: []const u8,

    /// The unique ID for the membership this configured table association belongs
    /// to.
    membership_id: []const u8,

    /// The name of the configured table association, in lowercase. The table is
    /// identified by this name when running protected queries against the
    /// underlying data.
    name: []const u8,

    /// The service will assume this role to access catalog metadata and query the
    /// table.
    role_arn: []const u8,

    /// The time the configured table association was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_rule_types = "analysisRuleTypes",
        .arn = "arn",
        .configured_table_arn = "configuredTableArn",
        .configured_table_id = "configuredTableId",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .role_arn = "roleArn",
        .update_time = "updateTime",
    };
};
