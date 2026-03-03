const RoutingRuleMatchBasePaths = @import("routing_rule_match_base_paths.zig").RoutingRuleMatchBasePaths;
const RoutingRuleMatchHeaders = @import("routing_rule_match_headers.zig").RoutingRuleMatchHeaders;

/// Represents a routing rule condition.
pub const RoutingRuleCondition = struct {
    /// The base path to be matched.
    match_base_paths: ?RoutingRuleMatchBasePaths = null,

    /// The headers to be matched.
    match_headers: ?RoutingRuleMatchHeaders = null,

    pub const json_field_names = .{
        .match_base_paths = "MatchBasePaths",
        .match_headers = "MatchHeaders",
    };
};
