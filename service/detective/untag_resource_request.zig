pub const UntagResourceRequest = struct {
    /// The ARN of the behavior graph to remove the tags from.
    resource_arn: []const u8,

    /// The tag keys of the tags to remove from the behavior graph. You can remove
    /// up to 50 tags
    /// at a time.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
