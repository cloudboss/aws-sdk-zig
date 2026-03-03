pub const ListMembersRequest = struct {
    /// The maximum number of items to include in each page of a paginated response.
    max_results: ?i32 = null,

    /// The nextToken string that specifies which page of results to return in a
    /// paginated response.
    next_token: ?[]const u8 = null,

    /// Specifies which accounts to include in the response, based on the status of
    /// an account's relationship with the administrator account. By default, the
    /// response includes only current member accounts. To include all accounts, set
    /// this value to false.
    only_associated: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .only_associated = "onlyAssociated",
    };
};
