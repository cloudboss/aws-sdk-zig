pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to untag.
    resource_arn: []const u8,

    /// The keys of the key-value pairs for the tag or tags you want to remove from
    /// the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
