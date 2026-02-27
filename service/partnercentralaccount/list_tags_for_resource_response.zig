const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The Amazon Resource Name (ARN) of the resource that the tags are associated
    /// with.
    resource_arn: []const u8,

    /// A list of tags associated with the specified resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
