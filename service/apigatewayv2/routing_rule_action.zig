const RoutingRuleActionInvokeApi = @import("routing_rule_action_invoke_api.zig").RoutingRuleActionInvokeApi;

/// The routing rule action.
pub const RoutingRuleAction = struct {
    invoke_api: RoutingRuleActionInvokeApi,

    pub const json_field_names = .{
        .invoke_api = "InvokeApi",
    };
};
