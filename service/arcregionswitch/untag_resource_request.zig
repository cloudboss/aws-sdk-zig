pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for a tag you remove a resource from.
    arn: []const u8,

    /// Tag keys that you remove from a resource.
    resource_tag_keys: []const []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .resource_tag_keys = "resourceTagKeys",
    };
};
