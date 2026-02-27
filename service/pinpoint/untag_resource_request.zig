pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// The key of the tag to remove from the resource. To remove multiple tags,
    /// append the tagKeys parameter and argument for each additional tag to remove,
    /// separated by an ampersand (&).
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
