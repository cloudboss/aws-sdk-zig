pub const ListClustersResponse = struct {
    /// The list of full Amazon Resource Name (ARN) entries for each cluster that's
    /// associated with your account.
    cluster_arns: ?[]const []const u8 = null,

    /// The `nextToken` value to include in a future `ListClusters` request. When
    /// the results of a `ListClusters` request exceed `maxResults`, this value can
    /// be used to retrieve the next page of results. This value is `null` when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arns = "clusterArns",
        .next_token = "nextToken",
    };
};
