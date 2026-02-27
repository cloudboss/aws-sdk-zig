const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    resource_arn: []const u8,

    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tags = "tags",
    };
};
