pub const ListApplicationsRequest = struct {
    /// The upper bound of the number of results to return (cannot exceed 25). If
    /// this parameter is omitted, it defaults to 25. This value is optional.
    max_results: ?i32 = null,

    /// The token to use to get the next page of results after a previous API call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
