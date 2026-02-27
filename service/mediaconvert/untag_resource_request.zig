pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to remove tags
    /// from. To get the ARN, send a GET request with the resource name.
    arn: []const u8,

    /// The keys of the tags that you want to remove from the resource.
    tag_keys: ?[]const []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .tag_keys = "TagKeys",
    };
};
