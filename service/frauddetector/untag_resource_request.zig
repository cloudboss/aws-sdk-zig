pub const UntagResourceRequest = struct {
    /// The ARN of the resource from which to remove the tag.
    resource_arn: []const u8,

    /// The resource ARN.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tag_keys = "tagKeys",
    };
};
