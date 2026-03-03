pub const ListGroupsRequest = struct {
    /// The identifier of the application for getting a list of groups mapped to
    /// users.
    application_id: []const u8,

    /// The identifier of the data source for getting a list of groups mapped to
    /// users.
    data_source_id: ?[]const u8 = null,

    /// The identifier of the index for getting a list of groups mapped to users.
    index_id: []const u8,

    /// The maximum number of returned groups that are mapped to users.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more data to
    /// retrieve), Amazon Q Business returns a pagination token in the response. You
    /// can use this pagination token to retrieve the next set of groups that are
    /// mapped to users.
    next_token: ?[]const u8 = null,

    /// The timestamp identifier used for the latest `PUT` or `DELETE` action for
    /// mapping users to their groups.
    updated_earlier_than: i64,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .index_id = "indexId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .updated_earlier_than = "updatedEarlierThan",
    };
};
