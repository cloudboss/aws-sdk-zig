const ActionSummary = @import("action_summary.zig").ActionSummary;
const EventSourceName = @import("event_source_name.zig").EventSourceName;
const RulePublishStatus = @import("rule_publish_status.zig").RulePublishStatus;

/// A list of `ActionTypes` associated with a rule.
pub const RuleSummary = struct {
    /// A list of ActionTypes associated with a rule.
    action_summaries: []const ActionSummary,

    /// The timestamp for when the rule was created.
    created_time: i64,

    /// The name of the event source.
    event_source_name: EventSourceName,

    /// The timestamp for when the rule was last updated.
    last_updated_time: i64,

    /// The name of the rule.
    name: []const u8,

    /// The publish status of the rule.
    publish_status: RulePublishStatus,

    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: []const u8,

    /// A unique identifier for the rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .action_summaries = "ActionSummaries",
        .created_time = "CreatedTime",
        .event_source_name = "EventSourceName",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .publish_status = "PublishStatus",
        .rule_arn = "RuleArn",
        .rule_id = "RuleId",
    };
};
