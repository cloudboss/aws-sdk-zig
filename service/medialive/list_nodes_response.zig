const DescribeNodeSummary = @import("describe_node_summary.zig").DescribeNodeSummary;

/// Placeholder documentation for ListNodesResponse
pub const ListNodesResponse = struct {
    /// Token for the next result.
    next_token: ?[]const u8 = null,

    /// An array of Nodes that exist in the Cluster.
    nodes: ?[]const DescribeNodeSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .nodes = "Nodes",
    };
};
