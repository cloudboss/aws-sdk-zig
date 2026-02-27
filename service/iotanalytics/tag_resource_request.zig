const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the resource whose tags you want to modify.
    resource_arn: []const u8,

    /// The new or modified tags for the resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
