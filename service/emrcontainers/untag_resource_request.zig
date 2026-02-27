pub const UntagResourceRequest = struct {
    /// The ARN of resources.
    resource_arn: []const u8,

    /// The tag keys of the resources.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
