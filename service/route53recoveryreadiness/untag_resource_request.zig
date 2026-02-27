pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for a resource.
    resource_arn: []const u8,

    /// The keys for tags you add to resources.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
