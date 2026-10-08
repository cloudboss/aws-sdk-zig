const NetworkTrafficRuleEffect = @import("network_traffic_rule_effect.zig").NetworkTrafficRuleEffect;
const NetworkTrafficRuleType = @import("network_traffic_rule_type.zig").NetworkTrafficRuleType;

/// A rule that controls network traffic during penetration testing by allowing
/// or denying traffic to specific URL patterns.
pub const NetworkTrafficRule = struct {
    /// The effect of the rule. Valid values are ALLOW and DENY.
    effect: ?NetworkTrafficRuleEffect = null,

    /// The type of the network traffic rule. Currently, only URL is supported.
    network_traffic_rule_type: ?NetworkTrafficRuleType = null,

    /// The URL pattern to match for the rule.
    pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .effect = "effect",
        .network_traffic_rule_type = "networkTrafficRuleType",
        .pattern = "pattern",
    };
};
