const aws = @import("aws");

const RuleAction = @import("rule_action.zig").RuleAction;
const RulePublishStatus = @import("rule_publish_status.zig").RulePublishStatus;
const RuleTriggerEventSource = @import("rule_trigger_event_source.zig").RuleTriggerEventSource;

/// Information about a rule.
pub const Rule = struct {
    /// A list of actions to be run when the rule is triggered.
    actions: []const RuleAction,

    /// The timestamp for when the rule was created.
    created_time: i64,

    /// The conditions of the rule.
    function: []const u8,

    /// The Amazon Resource Name (ARN) of the user who last updated the rule.
    last_updated_by: []const u8,

    /// The timestamp for the when the rule was last updated.
    last_updated_time: i64,

    /// The name of the rule.
    name: []const u8,

    /// The publish status of the rule.
    publish_status: RulePublishStatus,

    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: []const u8,

    /// A unique identifier for the rule.
    rule_id: []const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    /// The event source to trigger the rule.
    trigger_event_source: RuleTriggerEventSource,

    pub const json_field_names = .{
        .actions = "Actions",
        .created_time = "CreatedTime",
        .function = "Function",
        .last_updated_by = "LastUpdatedBy",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .publish_status = "PublishStatus",
        .rule_arn = "RuleArn",
        .rule_id = "RuleId",
        .tags = "Tags",
        .trigger_event_source = "TriggerEventSource",
    };
};
