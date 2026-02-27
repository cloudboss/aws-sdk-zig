pub const ListDomainsRequest = struct {
    /// The maximum number of objects returned per page.
    max_results: ?i32,

    /// The pagination token from the previous ListDomain API call.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
