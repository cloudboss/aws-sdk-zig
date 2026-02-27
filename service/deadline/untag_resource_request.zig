pub const UntagResourceRequest = struct {
    /// The ARN of the resource to remove the tag from.
    resource_arn: []const u8,

    /// They keys of the tag.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
