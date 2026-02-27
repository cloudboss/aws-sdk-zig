pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// One or more tags (keys) to remove from the resource. In an HTTP request to
    /// remove multiple tags, append the tagKeys parameter and argument for each tag
    /// to remove, separated by an ampersand (&).
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
