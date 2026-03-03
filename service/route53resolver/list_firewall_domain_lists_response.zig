const FirewallDomainListMetadata = @import("firewall_domain_list_metadata.zig").FirewallDomainListMetadata;

pub const ListFirewallDomainListsResponse = struct {
    /// A list of the domain lists that you have defined.
    ///
    /// This might be a partial list of the domain lists that you've defined. For
    /// information,
    /// see `MaxResults`.
    firewall_domain_lists: ?[]const FirewallDomainListMetadata = null,

    /// If objects are still available for retrieval, Resolver returns this token in
    /// the response.
    /// To retrieve the next batch of objects, provide this token in your next
    /// request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_domain_lists = "FirewallDomainLists",
        .next_token = "NextToken",
    };
};
