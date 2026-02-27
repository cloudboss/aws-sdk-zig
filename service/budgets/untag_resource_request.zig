pub const UntagResourceRequest = struct {
    /// The unique identifier for the resource.
    resource_arn: []const u8,

    /// The key that's associated with the tag.
    resource_tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .resource_tag_keys = "ResourceTagKeys",
    };
};
