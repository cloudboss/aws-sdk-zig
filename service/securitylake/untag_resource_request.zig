pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Security Lake resource to
    /// remove one or more tags from.
    resource_arn: []const u8,

    /// A list of one or more tag keys. For each value in the list, specify the tag
    /// key for a tag to remove from the Amazon Security Lake resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
