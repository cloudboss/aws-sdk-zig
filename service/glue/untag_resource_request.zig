pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource from which to remove the
    /// tags.
    resource_arn: []const u8,

    /// Tags to remove from this resource.
    tags_to_remove: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags_to_remove = "TagsToRemove",
    };
};
