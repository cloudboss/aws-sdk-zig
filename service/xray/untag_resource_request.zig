pub const UntagResourceRequest = struct {
    /// The Amazon Resource Number (ARN) of an X-Ray group or sampling rule.
    resource_arn: []const u8,

    /// Keys for one or more tags that you want to remove from an X-Ray group or
    /// sampling rule.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
