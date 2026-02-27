pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the given Amazon Translate resource from
    /// which you
    /// want to remove the tags.
    resource_arn: []const u8,

    /// The initial part of a key-value pair that forms a tag being removed from a
    /// given resource.
    /// Keys must be unique and cannot be duplicated for a particular resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
