pub const ListFirewallDomainsResponse = struct {
    /// A list of the domains in the firewall domain list.
    ///
    /// This might be a partial list of the domains that you've defined in the
    /// domain list. For
    /// information, see `MaxResults`.
    domains: ?[]const []const u8,

    /// If objects are still available for retrieval, Resolver returns this token in
    /// the response.
    /// To retrieve the next batch of objects, provide this token in your next
    /// request.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .domains = "Domains",
        .next_token = "NextToken",
    };
};
