pub const ListApplicationsRequest = struct {
    /// Maximum number of results to return
    max_results: ?i32 = null,

    /// Next Page Token
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
