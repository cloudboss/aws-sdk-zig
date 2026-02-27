pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Global Accelerator resource to remove
    /// tags from. An ARN uniquely identifies a resource.
    resource_arn: []const u8,

    /// The tag key pairs that you want to remove from the specified resources.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
