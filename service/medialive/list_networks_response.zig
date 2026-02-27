const DescribeNetworkSummary = @import("describe_network_summary.zig").DescribeNetworkSummary;

/// Placeholder documentation for ListNetworksResponse
pub const ListNetworksResponse = struct {
    /// An array of networks that you have created.
    networks: ?[]const DescribeNetworkSummary,

    /// Token for the next ListNetworks request.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .networks = "Networks",
        .next_token = "NextToken",
    };
};
