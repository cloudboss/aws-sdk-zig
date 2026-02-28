pub const ListTagsForResourceRequest = struct {
    limit: ?i32 = null,

    next_marker: ?[]const u8,

    resource_arn: []const u8,

    pub const json_field_names = .{
        .limit = "Limit",
        .next_marker = "NextMarker",
        .resource_arn = "ResourceARN",
    };
};
