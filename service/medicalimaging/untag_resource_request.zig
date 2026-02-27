pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the medical imaging resource that tags are
    /// being removed from.
    resource_arn: []const u8,

    /// The keys for the tags to be removed from the medical imaging resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
