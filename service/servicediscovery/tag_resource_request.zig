const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to retrieve
    /// tags for.
    resource_arn: []const u8,

    /// The tags to add to the specified resource. Specifying the tag key is
    /// required. You can set
    /// the value of a tag to an empty string, but you can't set the value of a tag
    /// to null.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
