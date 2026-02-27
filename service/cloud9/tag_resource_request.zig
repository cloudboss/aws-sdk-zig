const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Cloud9 development environment to add
    /// tags
    /// to.
    resource_arn: []const u8,

    /// The list of tags to add to the given Cloud9 development environment.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
