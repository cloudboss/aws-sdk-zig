pub const ListTagsForResourceRequest = struct {
    /// The ARN of the behavior graph for which to retrieve the tag values.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
