pub const ListChannelsRequest = struct {
    /// Upper bound on number of records to return.
    max_results: ?i32 = null,

    /// A token used to resume pagination from the end of a previous request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
