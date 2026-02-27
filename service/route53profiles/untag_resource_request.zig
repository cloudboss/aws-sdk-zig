pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource that you want to remove tags
    /// from.
    resource_arn: []const u8,

    /// The tags that you want to remove to the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
