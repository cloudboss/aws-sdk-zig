pub const ListTagsForResourceRequest = struct {
    /// The unique identifier for the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
