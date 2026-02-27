pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to untag.
    resource_arn: []const u8,

    /// Tag keys of the tags to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tag_keys = "tagKeys",
    };
};
