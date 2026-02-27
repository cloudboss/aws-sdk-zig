const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to add tags to. Currently,
    /// the supported
    /// resource is an Amazon ECR Public repository.
    resource_arn: []const u8,

    /// The tags to add to the resource. A tag is an array of key-value pairs.
    /// Tag keys can have a maximum character length of 128 characters, and tag
    /// values can have a maximum length of 256 characters.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
