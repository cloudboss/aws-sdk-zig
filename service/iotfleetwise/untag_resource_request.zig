pub const UntagResourceRequest = struct {
    /// The ARN of the resource.
    resource_arn: []const u8,

    /// A list of the keys of the tags to be removed from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
