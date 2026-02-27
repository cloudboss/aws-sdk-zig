pub const ListClustersResponse = struct {
    /// A list of all of the clusters for your account in the specified Amazon Web
    /// Services Region .
    clusters: ?[]const []const u8,

    /// The `nextToken` value returned from a previous paginated request, where
    /// `maxResults` was used and
    /// the results exceeded the value of that parameter. Pagination continues from
    /// the end of
    /// the previous results that returned the `nextToken` value. This value is null
    /// when there are no more results to return.
    ///
    /// This token should be treated as an opaque identifier that is used only to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .clusters = "clusters",
        .next_token = "nextToken",
    };
};
