const Action = @import("action.zig").Action;

pub const ListFirewallRulesRequest = struct {
    /// Optional additional filter for the rules to retrieve.
    ///
    /// The action that DNS Firewall should take on a DNS query when it matches one
    /// of the domains in the rule's domain list, or a threat in a DNS Firewall
    /// Advanced rule:
    ///
    /// * `ALLOW` - Permit the request to go through. Not availabe for DNS Firewall
    ///   Advanced rules.
    ///
    /// * `ALERT` - Permit the request to go through but send an alert to the logs.
    ///
    /// * `BLOCK` - Disallow the request. If this is specified, additional handling
    ///   details are provided in the rule's `BlockResponse` setting.
    action: ?Action,

    /// The unique identifier of the firewall rule group that you want to retrieve
    /// the rules for.
    firewall_rule_group_id: []const u8,

    /// The maximum number of objects that you want Resolver to return for this
    /// request. If more
    /// objects are available, in the response, Resolver provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    ///
    /// If you don't specify a value for `MaxResults`, Resolver returns up to 100
    /// objects.
    max_results: ?i32,

    /// For the first call to this list request, omit this value.
    ///
    /// When you request a list of objects, Resolver returns at most the number of
    /// objects
    /// specified in `MaxResults`. If more objects are available for retrieval,
    /// Resolver returns a `NextToken` value in the response. To retrieve the next
    /// batch of objects, use the token that was returned for the prior request in
    /// your next request.
    next_token: ?[]const u8,

    /// Optional additional filter for the rules to retrieve.
    ///
    /// The setting that determines the processing order of the rules in a rule
    /// group. DNS Firewall
    /// processes the rules in a rule group by order of priority, starting from the
    /// lowest setting.
    priority: ?i32,

    pub const json_field_names = .{
        .action = "Action",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .priority = "Priority",
    };
};
