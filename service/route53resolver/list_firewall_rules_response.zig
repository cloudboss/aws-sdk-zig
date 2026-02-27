const FirewallRule = @import("firewall_rule.zig").FirewallRule;

pub const ListFirewallRulesResponse = struct {
    /// A list of the rules that you have defined.
    ///
    /// This might be a partial list of the firewall rules that you've defined. For
    /// information,
    /// see `MaxResults`.
    firewall_rules: ?[]const FirewallRule,

    /// If objects are still available for retrieval, Resolver returns this token in
    /// the response.
    /// To retrieve the next batch of objects, provide this token in your next
    /// request.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .firewall_rules = "FirewallRules",
        .next_token = "NextToken",
    };
};
