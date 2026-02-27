pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the tagged resource.
    resource_arn: []const u8,

    /// The keys used to identify the tags.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
