pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the application that you want to retrieve
    /// tag
    /// information for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
