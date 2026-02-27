const ActionValue = @import("action_value.zig").ActionValue;

/// A single action condition for a Condition in a logging filter.
pub const ActionCondition = struct {
    /// The action setting that a log record must contain in order to meet the
    /// condition. This is the action that WAF applied to the web request.
    ///
    /// For rule groups, this is either the configured rule action setting, or if
    /// you've applied a rule action override to the rule, it's the override action.
    /// The value `EXCLUDED_AS_COUNT` matches on
    /// excluded rules and also on rules that have a rule action override of Count.
    action: ActionValue,

    pub const json_field_names = .{
        .action = "Action",
    };
};
