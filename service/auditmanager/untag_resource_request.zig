pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the specified resource.
    resource_arn: []const u8,

    /// The name or key of the tag.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
