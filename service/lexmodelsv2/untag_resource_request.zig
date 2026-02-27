pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to remove the tags
    /// from.
    resource_arn: []const u8,

    /// A list of tag keys to remove from the resource. If a tag key does
    /// not exist on the resource, it is ignored.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tag_keys = "tagKeys",
    };
};
