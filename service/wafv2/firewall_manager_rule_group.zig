const FirewallManagerStatement = @import("firewall_manager_statement.zig").FirewallManagerStatement;
const OverrideAction = @import("override_action.zig").OverrideAction;
const VisibilityConfig = @import("visibility_config.zig").VisibilityConfig;

/// A rule group that's defined for an Firewall Manager WAF policy.
pub const FirewallManagerRuleGroup = struct {
    /// The processing guidance for an Firewall Manager rule. This is like a regular
    /// rule Statement, but it can only contain a rule group reference.
    firewall_manager_statement: FirewallManagerStatement,

    /// The name of the rule group. You cannot change the name of a rule group after
    /// you create it.
    name: []const u8,

    /// The action to use in the place of the action that results from the rule
    /// group evaluation. Set the override action to none to leave the result of the
    /// rule group alone. Set it to count to override the result to count only.
    ///
    /// You can only use this for rule statements that reference a rule group, like
    /// `RuleGroupReferenceStatement` and `ManagedRuleGroupStatement`.
    ///
    /// This option is usually set to none. It does not affect how the rules in the
    /// rule group are evaluated. If you want the rules in the rule group to only
    /// count
    /// matches, do not use this and instead use the rule action override option,
    /// with `Count` action, in your rule group reference statement settings.
    override_action: OverrideAction,

    /// If you define more than one rule group in the first or last Firewall Manager
    /// rule groups, WAF
    /// evaluates each request against the rule groups in order, starting from the
    /// lowest priority
    /// setting. The priorities don't need to be consecutive, but they must all be
    /// different.
    priority: i32 = 0,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: VisibilityConfig,

    pub const json_field_names = .{
        .firewall_manager_statement = "FirewallManagerStatement",
        .name = "Name",
        .override_action = "OverrideAction",
        .priority = "Priority",
        .visibility_config = "VisibilityConfig",
    };
};
