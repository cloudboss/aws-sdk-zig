pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to remove tags
    /// from.
    resource_arn: []const u8,

    /// The tag key for each tag that you want to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
