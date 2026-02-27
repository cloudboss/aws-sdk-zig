pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource to remove tags from.
    resource_arn: []const u8,

    /// The tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
