const IntermediateTableAnalysisRuleType = @import("intermediate_table_analysis_rule_type.zig").IntermediateTableAnalysisRuleType;
const IntermediateTableStatus = @import("intermediate_table_status.zig").IntermediateTableStatus;

/// Contains summary information about an intermediate table.
pub const IntermediateTableSummary = struct {
    /// The types of analysis rules associated with the intermediate table.
    analysis_rule_types: ?[]const IntermediateTableAnalysisRuleType = null,

    /// The Amazon Resource Name (ARN) of the intermediate table.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the collaboration that contains the
    /// intermediate table.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains the intermediate
    /// table.
    collaboration_id: []const u8,

    /// The time the intermediate table was created.
    create_time: i64,

    /// The description of the intermediate table.
    description: ?[]const u8 = null,

    /// The unique identifier of the intermediate table.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the membership that contains the
    /// intermediate table.
    membership_arn: []const u8,

    /// The unique identifier of the membership that contains the intermediate
    /// table.
    membership_id: []const u8,

    /// The name of the intermediate table.
    name: []const u8,

    /// The number of days that populated data is retained before expiring.
    retention_in_days: ?i32 = null,

    /// The current status of the intermediate table.
    status: IntermediateTableStatus,

    /// The time the intermediate table was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_rule_types = "analysisRuleTypes",
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .retention_in_days = "retentionInDays",
        .status = "status",
        .update_time = "updateTime",
    };
};
