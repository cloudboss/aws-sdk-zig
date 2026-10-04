pub const UntagResourceRequest = struct {
    /// The ARN of the ACM resource from which the tag is to be removed.
    resource_arn: []const u8,

    /// The key of each tag to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
