const RuleAction = @import("rule_action.zig").RuleAction;
const RulePublishStatus = @import("rule_publish_status.zig").RulePublishStatus;
const RuleTriggerEventSource = @import("rule_trigger_event_source.zig").RuleTriggerEventSource;

pub const CreateRuleRequest = struct {
    /// A list of actions to be run when the rule is triggered.
    actions: []const RuleAction,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8,

    /// The conditions of the rule.
    function: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// A unique name for the rule.
    name: []const u8,

    /// The publish status of the rule.
    publish_status: RulePublishStatus,

    /// The event source to trigger the rule.
    trigger_event_source: RuleTriggerEventSource,

    pub const json_field_names = .{
        .actions = "Actions",
        .client_token = "ClientToken",
        .function = "Function",
        .instance_id = "InstanceId",
        .name = "Name",
        .publish_status = "PublishStatus",
        .trigger_event_source = "TriggerEventSource",
    };
};
