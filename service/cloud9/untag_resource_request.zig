pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Cloud9 development environment to
    /// remove tags
    /// from.
    resource_arn: []const u8,

    /// The tag names of the tags to remove from the given Cloud9 development
    /// environment.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
