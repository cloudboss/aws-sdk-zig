pub const ListTagsForResourceRequest = struct {
    /// (Optional) Specifies the maximum number of tag objects to return in the
    /// response. The default value is 100.
    max_results: ?i32 = null,

    /// (Optional) You can use `NextToken` in a subsequent request to fetch the next
    /// page of access point descriptions if the response payload was paginated.
    next_token: ?[]const u8 = null,

    /// Specifies the EFS resource you want to retrieve tags for. You can retrieve
    /// tags
    /// for EFS file systems and access points using this API endpoint.
    resource_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_id = "ResourceId",
    };
};
