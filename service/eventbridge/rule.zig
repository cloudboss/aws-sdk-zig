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
    /// Patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-and-event-patterns.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    event_pattern: ?[]const u8 = null,

    /// If the rule was created on behalf of your account by an Amazon Web Services
    /// service, this
    /// field displays the principal name of the service that created the rule.
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
    /// minutes)". For more
    /// information, see [Creating an Amazon EventBridge rule
    /// that runs on a
    /// schedule](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-create-rule-schedule.html).
    schedule_expression: ?[]const u8 = null,

    /// The state of the rule.
    ///
    /// Valid values include:
    ///
    /// * `DISABLED`: The rule is disabled. EventBridge does not match any events
    ///   against the rule.
    ///
    /// * `ENABLED`: The rule is enabled.
    /// EventBridge matches events against the rule, *except* for Amazon Web
    /// Services management events delivered through CloudTrail.
    ///
    /// * `ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS`: The rule is enabled for
    ///   all
    /// events, including Amazon Web Services management events delivered through
    /// CloudTrail.
    ///
    /// Management events provide visibility into management operations that are
    /// performed on
    /// resources in your Amazon Web Services account. These are also known as
    /// control plane
    /// operations. For more information, see [Logging management
    /// events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-management-events-with-cloudtrail.html#logging-management-events) in the *CloudTrail User
    /// Guide*, and [Filtering management events from Amazon Web Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-cloudtrail) in the
    /// *
    /// Amazon EventBridge User Guide*
    /// .
    ///
    /// This value is only valid for rules on the
    /// [default](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is-how-it-works-concepts.html#eb-bus-concepts-buses) event bus
    /// or [custom event
    /// buses](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-create-event-bus.html).
    /// It does not apply to [partner event
    /// buses](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-saas.html).
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
