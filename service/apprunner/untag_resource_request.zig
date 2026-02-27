pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to remove tags
    /// from.
    ///
    /// It must be the ARN of an App Runner resource.
    resource_arn: []const u8,

    /// A list of tag keys that you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
