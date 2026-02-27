pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q Business application or data
    /// source to get a list of tags for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
    };
};
