const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource. The resource must be active
    /// (not in the `DELETING` state), and must be owned by the account ID included
    /// in the request.
    resource_arn: []const u8,

    /// A list of tags (key-value pairs) to add to the resource. All tag keys in the
    /// request must be unique.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
