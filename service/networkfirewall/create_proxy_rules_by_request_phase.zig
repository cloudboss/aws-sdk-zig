const CreateProxyRule = @import("create_proxy_rule.zig").CreateProxyRule;

/// Evaluation points in the traffic flow where rules are applied. There are
/// three phases in a traffic where the rule match is applied.
///
/// This data type is used specifically for the CreateProxyRules API.
///
/// Pre-DNS - before domain resolution.
///
/// Pre-Request - after DNS, before request.
///
/// Post-Response - after receiving response.
pub const CreateProxyRulesByRequestPhase = struct {
    /// After receiving response.
    post_response: ?[]const CreateProxyRule,

    /// Before domain resolution.
    pre_dns: ?[]const CreateProxyRule,

    /// After DNS, before request.
    pre_request: ?[]const CreateProxyRule,

    pub const json_field_names = .{
        .post_response = "PostRESPONSE",
        .pre_dns = "PreDNS",
        .pre_request = "PreREQUEST",
    };
};
