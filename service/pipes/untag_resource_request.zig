pub const UntagResourceRequest = struct {
    /// The ARN of the pipe.
    resource_arn: []const u8,

    /// The list of tag keys to remove from the pipe.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
