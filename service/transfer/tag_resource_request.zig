const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// An Amazon Resource Name (ARN) for a specific Amazon Web Services resource,
    /// such as a server, user, or role.
    arn: []const u8,

    /// Key-value pairs assigned to ARNs that you can use to group and search for
    /// resources by type. You can attach this metadata to resources (servers,
    /// users, workflows, and so on) for any purpose.
    tags: []const Tag,

    pub const json_field_names = .{
        .arn = "Arn",
        .tags = "Tags",
    };
};
