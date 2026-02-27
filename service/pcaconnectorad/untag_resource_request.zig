pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that was returned when you created the
    /// resource.
    resource_arn: []const u8,

    /// Specifies a list of tag keys that you want to remove from the specified
    /// resources.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
