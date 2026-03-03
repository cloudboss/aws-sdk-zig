pub const DeleteRuleRequest = struct {
    /// The name or ARN of the event bus associated with the rule. If you omit this,
    /// the default
    /// event bus is used.
    event_bus_name: ?[]const u8 = null,

    /// If this is a managed rule, created by an Amazon Web Services service on your
    /// behalf, you
    /// must specify `Force` as `True` to delete the rule. This parameter is
    /// ignored for rules that are not managed rules. You can check whether a rule
    /// is a managed rule
    /// by using `DescribeRule` or `ListRules` and checking the
    /// `ManagedBy` field of the response.
    force: ?bool = null,

    /// The name of the rule.
    name: []const u8,

    pub const json_field_names = .{
        .event_bus_name = "EventBusName",
        .force = "Force",
        .name = "Name",
    };
};
