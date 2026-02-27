pub const UntagResourceRequest = struct {
    /// The ARN of the resource the tag association is removed from.
    resource_arn: []const u8,

    /// The key values of the tag to be removed from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
