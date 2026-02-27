pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to untag.
    resource_arn: []const u8,

    /// The tag keys to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
