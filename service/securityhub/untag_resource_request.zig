pub const UntagResourceRequest = struct {
    /// The ARN of the resource to remove the tags from.
    resource_arn: []const u8,

    /// The tag keys associated with the tags to remove from the resource. You can
    /// remove up to 50 tags at a time.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
