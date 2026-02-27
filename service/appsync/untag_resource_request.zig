pub const UntagResourceRequest = struct {
    /// The `GraphqlApi` Amazon Resource Name (ARN).
    resource_arn: []const u8,

    /// A list of `TagKey` objects.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
