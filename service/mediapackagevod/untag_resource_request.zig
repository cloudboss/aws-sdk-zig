pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource. You can get this from the
    /// response to any request to the resource.
    resource_arn: []const u8,

    /// A comma-separated list of the tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
