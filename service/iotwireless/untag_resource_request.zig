pub const UntagResourceRequest = struct {
    /// The ARN of the resource to remove tags from.
    resource_arn: []const u8,

    /// A list of the keys of the tags to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
