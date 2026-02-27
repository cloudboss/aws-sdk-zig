pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to retrieve
    /// tags for.
    resource_arn: []const u8,

    /// The tag keys to remove from the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
