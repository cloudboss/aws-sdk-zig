pub const ListClustersRequest = struct {
    /// Indicates whether external clusters are included in the returned list. Use
    /// '`all`' to return
    /// [https://docs.aws.amazon.com/eks/latest/userguide/eks-connector.html](https://docs.aws.amazon.com/eks/latest/userguide/eks-connector.html)connected clusters, or blank to
    /// return only Amazon EKS clusters. '`all`' must be in lowercase otherwise an
    /// error
    /// occurs.
    include: ?[]const []const u8 = null,

    /// The maximum number of results, returned in paginated output. You receive
    /// `maxResults` in a single page, along with a `nextToken`
    /// response element. You can see the remaining results of the initial request
    /// by sending
    /// another request with the returned `nextToken` value. This value can be
    /// between 1 and 100. If you don't use this parameter,
    /// 100 results and a `nextToken` value, if applicable, are
    /// returned.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated request, where
    /// `maxResults` was used and
    /// the results exceeded the value of that parameter. Pagination continues from
    /// the end of
    /// the previous results that returned the `nextToken` value. This value is null
    /// when there are no more results to return.
    ///
    /// This token should be treated as an opaque identifier that is used only to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .include = "include",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
