pub const GetQueryResultsRequest = struct {
    /// The maximum number of results to return for each paginated request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// The unique identifier for the query execution.
    query_id: []const u8,

    /// The name of the workspace associated with the query.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .query_id = "queryId",
        .workspace_name = "workspaceName",
    };
};
