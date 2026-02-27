pub const ListServicesRequest = struct {
    /// The maximum number of results to include in each response (result page).
    /// It's used for a paginated request.
    ///
    /// If you don't specify `MaxResults`, the request retrieves all available
    /// results in a single response.
    max_results: ?i32,

    /// A token from a previous result page. Used for a paginated request. The
    /// request retrieves the next result page. All other parameter values must be
    /// identical to the ones specified in the initial request.
    ///
    /// If you don't specify `NextToken`, the request retrieves the first result
    /// page.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
