/// Placeholder documentation for ListNodesRequest
pub const ListNodesRequest = struct {
    /// The ID of the cluster
    cluster_id: []const u8,

    /// The maximum number of items to return.
    max_results: ?i32,

    /// The token to retrieve the next page of results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
