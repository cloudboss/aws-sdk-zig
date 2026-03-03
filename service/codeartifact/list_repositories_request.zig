pub const ListRepositoriesRequest = struct {
    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// A prefix used to filter returned repositories. Only repositories with names
    /// that start
    /// with `repositoryPrefix` are returned.
    repository_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .repository_prefix = "repositoryPrefix",
    };
};
