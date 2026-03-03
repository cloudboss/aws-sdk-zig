const ProxyRulePhaseAction = @import("proxy_rule_phase_action.zig").ProxyRulePhaseAction;

/// Evaluation points in the traffic flow where rules are applied. There are
/// three phases in a traffic where the rule match is applied.
///
/// This data type is used specifically for the CreateProxyConfiguration and
/// UpdateProxyConfiguration APIs.
pub const ProxyConfigDefaultRulePhaseActionsRequest = struct {
    /// After receiving response.
    post_response: ?ProxyRulePhaseAction = null,

    /// Before domain resolution.
    pre_dns: ?ProxyRulePhaseAction = null,

    /// After DNS, before request.
    pre_request: ?ProxyRulePhaseAction = null,

    pub const json_field_names = .{
        .post_response = "PostRESPONSE",
        .pre_dns = "PreDNS",
        .pre_request = "PreREQUEST",
    };
};
