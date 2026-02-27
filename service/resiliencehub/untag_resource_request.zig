pub const UntagResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// The keys of the tags you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
