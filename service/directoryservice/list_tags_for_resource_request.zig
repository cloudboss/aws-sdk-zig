pub const ListTagsForResourceRequest = struct {
    /// Reserved for future use.
    limit: ?i32 = null,

    /// Reserved for future use.
    next_token: ?[]const u8 = null,

    /// Identifier (ID) of the directory for which you want to retrieve tags.
    resource_id: []const u8,

    pub const json_field_names = .{
        .limit = "Limit",
        .next_token = "NextToken",
        .resource_id = "ResourceId",
    };
};
