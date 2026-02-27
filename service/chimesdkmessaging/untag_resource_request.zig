pub const UntagResourceRequest = struct {
    /// The resource ARN.
    resource_arn: []const u8,

    /// The tag keys.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
