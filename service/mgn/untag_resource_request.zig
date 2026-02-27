pub const UntagResourceRequest = struct {
    /// Untag resource by ARN.
    resource_arn: []const u8,

    /// Untag resource by Keys.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
