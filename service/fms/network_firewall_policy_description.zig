const StatefulEngineOptions = @import("stateful_engine_options.zig").StatefulEngineOptions;
const StatefulRuleGroup = @import("stateful_rule_group.zig").StatefulRuleGroup;
const StatelessRuleGroup = @import("stateless_rule_group.zig").StatelessRuleGroup;

/// The definition of the Network Firewall firewall policy.
pub const NetworkFirewallPolicyDescription = struct {
    /// The default actions to take on a packet that doesn't match any stateful
    /// rules. The stateful default
    /// action is optional, and is only valid when using the strict rule order.
    ///
    /// Valid values of the stateful default action:
    ///
    /// * aws:drop_strict
    ///
    /// * aws:drop_established
    ///
    /// * aws:alert_strict
    ///
    /// * aws:alert_established
    stateful_default_actions: ?[]const []const u8 = null,

    /// Additional options governing how Network Firewall handles stateful rules.
    /// The stateful rule groups
    /// that you use in your policy must have stateful rule options settings that
    /// are compatible with these
    /// settings.
    stateful_engine_options: ?StatefulEngineOptions = null,

    /// The stateful rule groups that are used in the Network Firewall firewall
    /// policy.
    stateful_rule_groups: ?[]const StatefulRuleGroup = null,

    /// Names of custom actions that are available for use in the stateless default
    /// actions settings.
    stateless_custom_actions: ?[]const []const u8 = null,

    /// The actions to take on packets that don't match any of the stateless rule
    /// groups.
    stateless_default_actions: ?[]const []const u8 = null,

    /// The actions to take on packet fragments that don't match any of the
    /// stateless rule groups.
    stateless_fragment_default_actions: ?[]const []const u8 = null,

    /// The stateless rule groups that are used in the Network Firewall firewall
    /// policy.
    stateless_rule_groups: ?[]const StatelessRuleGroup = null,

    pub const json_field_names = .{
        .stateful_default_actions = "StatefulDefaultActions",
        .stateful_engine_options = "StatefulEngineOptions",
        .stateful_rule_groups = "StatefulRuleGroups",
        .stateless_custom_actions = "StatelessCustomActions",
        .stateless_default_actions = "StatelessDefaultActions",
        .stateless_fragment_default_actions = "StatelessFragmentDefaultActions",
        .stateless_rule_groups = "StatelessRuleGroups",
    };
};
