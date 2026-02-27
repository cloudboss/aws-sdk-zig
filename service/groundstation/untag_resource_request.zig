pub const UntagResourceRequest = struct {
    /// ARN of a resource.
    resource_arn: []const u8,

    /// Keys of a resource tag.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
