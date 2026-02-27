pub const ListTagsForResourceRequest = struct {
    /// The ARN of the resource that you want to see the tags of.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
