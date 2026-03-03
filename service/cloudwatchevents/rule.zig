const RuleState = @import("rule_state.zig").RuleState;

/// Contains information about a rule in Amazon EventBridge.
pub const Rule = struct {
    /// The Amazon Resource Name (ARN) of the rule.
    arn: ?[]const u8 = null,

    /// The description of the rule.
    description: ?[]const u8 = null,

    /// The name or ARN of the event bus associated with the rule. If you omit this,
    /// the default
    /// event bus is used.
    event_bus_name: ?[]const u8 = null,

    /// The event pattern of the rule. For more information, see [Events and Event
    /// Patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-and-event-patterns.html) in the *Amazon EventBridge User Guide*.
    event_pattern: ?[]const u8 = null,

    /// If the rule was created on behalf of your account by an Amazon Web Services
    /// service, this field displays
    /// the principal name of the service that created the rule.
    managed_by: ?[]const u8 = null,

    /// The name of the rule.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role that is used for target
    /// invocation.
    ///
    /// If you're setting an event bus in another account as the target and that
    /// account granted
    /// permission to your account through an organization instead of directly by
    /// the account ID, you
    /// must specify a `RoleArn` with proper permissions in the `Target`
    /// structure, instead of here in this parameter.
    role_arn: ?[]const u8 = null,

    /// The scheduling expression. For example, "cron(0 20 * * ? *)", "rate(5
    /// minutes)". For more information, see [Creating an Amazon EventBridge rule
    /// that runs on a
    /// schedule](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-create-rule-schedule.html).
    schedule_expression: ?[]const u8 = null,

    /// The state of the rule.
    state: ?RuleState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .event_bus_name = "EventBusName",
        .event_pattern = "EventPattern",
        .managed_by = "ManagedBy",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule_expression = "ScheduleExpression",
        .state = "State",
    };
};
