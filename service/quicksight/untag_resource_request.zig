pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to untag.
    resource_arn: []const u8,

    /// The keys of the key-value pairs for the resource tag or tags assigned to the
    /// resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
