const FleetProxyRuleBehavior = @import("fleet_proxy_rule_behavior.zig").FleetProxyRuleBehavior;
const FleetProxyRule = @import("fleet_proxy_rule.zig").FleetProxyRule;

/// Information about the proxy configurations that apply network access control
/// to your reserved capacity instances.
pub const ProxyConfiguration = struct {
    /// The default behavior of outgoing traffic.
    default_behavior: ?FleetProxyRuleBehavior,

    /// An array of `FleetProxyRule` objects that represent the specified
    /// destination domains or IPs to allow or deny network access control to.
    ordered_proxy_rules: ?[]const FleetProxyRule,

    pub const json_field_names = .{
        .default_behavior = "defaultBehavior",
        .ordered_proxy_rules = "orderedProxyRules",
    };
};
