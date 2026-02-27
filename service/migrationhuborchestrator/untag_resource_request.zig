pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource from which you want to remove
    /// tags.
    resource_arn: []const u8,

    /// One or more tag keys. Specify only the tag keys, not the tag values.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
