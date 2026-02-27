const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to add one or
    /// more tags
    /// to.
    resource_arn: []const u8,

    /// A list of the tags that you want to add to the resource. A tag consists of a
    /// required
    /// tag key (`Key`) and an associated tag value (`Value`). The maximum
    /// length of a tag key is 128 characters. The maximum length of a tag value is
    /// 256
    /// characters.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
