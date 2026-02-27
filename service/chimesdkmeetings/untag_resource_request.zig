pub const UntagResourceRequest = struct {
    /// The ARN of the resource that you're removing tags from.
    resource_arn: []const u8,

    /// The tag keys being removed from the resources.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
