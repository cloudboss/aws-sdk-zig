pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services resource to remove
    /// the metadata tags from.
    resource_arn: []const u8,

    /// A list of metadata tag keys to remove from the requested
    /// resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
