const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the given Amazon Comprehend resource to
    /// which you want
    /// to associate the tags.
    resource_arn: []const u8,

    /// Tags being associated with a specific Amazon Comprehend resource. There can
    /// be a maximum
    /// of 50 tags (both existing and pending) associated with a specific resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
