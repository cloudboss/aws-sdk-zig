pub const ListFirewallDomainListsRequest = struct {
    /// The maximum number of objects that you want Resolver to return for this
    /// request. If more
    /// objects are available, in the response, Resolver provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    ///
    /// If you don't specify a value for `MaxResults`, Resolver returns up to 100
    /// objects.
    max_results: ?i32,

    /// For the first call to this list request, omit this value.
    ///
    /// When you request a list of objects, Resolver returns at most the number of
    /// objects
    /// specified in `MaxResults`. If more objects are available for retrieval,
    /// Resolver returns a `NextToken` value in the response. To retrieve the next
    /// batch of objects, use the token that was returned for the prior request in
    /// your next request.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
