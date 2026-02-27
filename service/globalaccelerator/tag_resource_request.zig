const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Global Accelerator resource to add
    /// tags to. An ARN uniquely identifies a resource.
    resource_arn: []const u8,

    /// The tags to add to a resource. A tag consists of a key and a value that you
    /// define.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
