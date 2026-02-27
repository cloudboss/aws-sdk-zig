pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the response plan you're removing a tag
    /// from.
    resource_arn: []const u8,

    /// The name of the tag to remove from the response plan.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
