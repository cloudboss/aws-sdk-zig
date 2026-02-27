pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to which the tag is currently
    /// associated.
    resource_arn: []const u8,

    /// Specifies the key of the tag to be removed from a specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
