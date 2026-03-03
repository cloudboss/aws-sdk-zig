pub const ListNodesRequest = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: []const u8,

    /// The maximum number of results to return in the response. If there are more
    /// results, the response includes a NextToken parameter.
    max_results: ?i32 = null,

    /// The paginated results marker. When the result of the operation is truncated,
    /// the call returns NextToken in the response.
    /// To get the next batch, provide this token in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
