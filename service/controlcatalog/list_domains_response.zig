const DomainSummary = @import("domain_summary.zig").DomainSummary;

pub const ListDomainsResponse = struct {
    /// The list of domains that the `ListDomains` API returns.
    domains: []const DomainSummary,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .domains = "Domains",
        .next_token = "NextToken",
    };
};
