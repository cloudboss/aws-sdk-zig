pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource from which to remove tags.
    resource_arn: []const u8,

    /// A list of tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
