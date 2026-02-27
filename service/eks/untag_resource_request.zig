pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to delete tags from.
    resource_arn: []const u8,

    /// The keys of the tags to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
