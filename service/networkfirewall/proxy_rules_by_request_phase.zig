const ProxyRule = @import("proxy_rule.zig").ProxyRule;

/// Evaluation points in the traffic flow where rules are applied. There are
/// three phases in a traffic where the rule match is applied.
pub const ProxyRulesByRequestPhase = struct {
    /// After receiving response.
    post_response: ?[]const ProxyRule,

    /// Before domain resolution.
    pre_dns: ?[]const ProxyRule,

    /// After DNS, before request.
    pre_request: ?[]const ProxyRule,

    pub const json_field_names = .{
        .post_response = "PostRESPONSE",
        .pre_dns = "PreDNS",
        .pre_request = "PreREQUEST",
    };
};
