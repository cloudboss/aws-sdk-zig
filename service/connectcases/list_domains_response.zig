const DomainSummary = @import("domain_summary.zig").DomainSummary;

pub const ListDomainsResponse = struct {
    /// The Cases domain.
    domains: []const DomainSummary,

    /// The token for the next set of results. This is null if there are no more
    /// results to return.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .domains = "domains",
        .next_token = "nextToken",
    };
};
