pub const UntagResourceRequest = struct {
    /// The ARN of the resource for which to remove tags.
    resource_arn: []const u8,

    /// The tag keys to delete.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
