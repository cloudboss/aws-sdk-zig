pub const ListClustersRequest = struct {
    /// The maximum number of cluster results that `ListClusters` returned in
    /// paginated output. When this parameter is used, `ListClusters` only returns
    /// `maxResults` results in a single page along with a `nextToken`
    /// response element. The remaining results of the initial request can be seen
    /// by sending
    /// another `ListClusters` request with the returned `nextToken`
    /// value. This value can be between 1 and 100. If this parameter isn't used,
    /// then
    /// `ListClusters` returns up to 100 results and a `nextToken`
    /// value if applicable.
    max_results: ?i32,

    /// The `nextToken` value returned from a `ListClusters` request
    /// indicating that more results are available to fulfill the request and
    /// further calls are
    /// needed. If `maxResults` was provided, it's possible the number of results to
    /// be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve
    /// the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
