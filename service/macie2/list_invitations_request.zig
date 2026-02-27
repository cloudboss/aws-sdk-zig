pub const ListInvitationsRequest = struct {
    /// The maximum number of items to include in each page of a paginated response.
    max_results: ?i32,

    /// The nextToken string that specifies which page of results to return in a
    /// paginated response.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
