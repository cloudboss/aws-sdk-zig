pub const ListTagsForResourceRequest = struct {
    /// The ARN of the application for which to retrieve tags.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
