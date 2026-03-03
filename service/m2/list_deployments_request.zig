pub const ListDeploymentsRequest = struct {
    /// The application identifier.
    application_id: []const u8,

    /// The maximum number of objects to return.
    max_results: ?i32 = null,

    /// A pagination token returned from a previous call to
    /// this operation. This specifies the next item to return. To return to the
    /// beginning of the
    /// list, exclude this parameter.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
