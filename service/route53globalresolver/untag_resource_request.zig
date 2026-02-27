pub const UntagResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// The tag keys associated with the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
