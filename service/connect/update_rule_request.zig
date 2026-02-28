const RuleAction = @import("rule_action.zig").RuleAction;
const RulePublishStatus = @import("rule_publish_status.zig").RulePublishStatus;

pub const UpdateRuleRequest = struct {
    /// A list of actions to be run when the rule is triggered.
    actions: []const RuleAction,

    /// The conditions of the rule.
    function: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The name of the rule. You can change the name only if `TriggerEventSource`
    /// is one of the following
    /// values: `OnZendeskTicketCreate` | `OnZendeskTicketStatusUpdate` |
    /// `OnSalesforceCaseCreate`
    name: []const u8,

    /// The publish status of the rule.
    publish_status: RulePublishStatus,

    /// A unique identifier for the rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .function = "Function",
        .instance_id = "InstanceId",
        .name = "Name",
        .publish_status = "PublishStatus",
        .rule_id = "RuleId",
    };
};
