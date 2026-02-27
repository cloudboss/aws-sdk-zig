pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource from which you want to remove
    /// tags.
    resource_arn: []const u8,

    /// The keys of the tags that you want to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
