const RoutingRuleMatchHeaderValue = @import("routing_rule_match_header_value.zig").RoutingRuleMatchHeaderValue;

/// Represents a MatchHeaders condition.
pub const RoutingRuleMatchHeaders = struct {
    /// The header name and header value glob to be matched. The matchHeaders
    /// condition is matched if any of the header name and header value globs are
    /// matched.
    any_of: []const RoutingRuleMatchHeaderValue,

    pub const json_field_names = .{
        .any_of = "AnyOf",
    };
};
