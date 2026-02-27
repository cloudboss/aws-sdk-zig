const FleetProxyRuleEffectType = @import("fleet_proxy_rule_effect_type.zig").FleetProxyRuleEffectType;
const FleetProxyRuleType = @import("fleet_proxy_rule_type.zig").FleetProxyRuleType;

/// Information about the proxy rule for your reserved capacity instances.
pub const FleetProxyRule = struct {
    /// The behavior of the proxy rule.
    effect: FleetProxyRuleEffectType,

    /// The destination of the proxy rule.
    entities: []const []const u8,

    /// The type of proxy rule.
    type: FleetProxyRuleType,

    pub const json_field_names = .{
        .effect = "effect",
        .entities = "entities",
        .type = "type",
    };
};
