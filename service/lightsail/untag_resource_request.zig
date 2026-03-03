pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource from which you want to remove
    /// a tag.
    resource_arn: ?[]const u8 = null,

    /// The name of the resource from which you are removing a tag.
    resource_name: []const u8,

    /// The tag keys to delete from the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_name = "resourceName",
        .tag_keys = "tagKeys",
    };
};
