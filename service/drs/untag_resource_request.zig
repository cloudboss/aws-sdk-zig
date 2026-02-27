pub const UntagResourceRequest = struct {
    /// ARN of the resource for which tags are to be removed.
    resource_arn: []const u8,

    /// Array of tags to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
