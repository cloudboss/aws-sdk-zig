pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that specifies the resource to be untagged.
    resource_arn: []const u8,

    /// Specifies the tags to be removed from the resource specified by the
    /// ResourceARN.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
