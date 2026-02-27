const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to return tags for. The
    /// Firewall Manager resources that support tagging are policies, applications
    /// lists, and protocols lists.
    resource_arn: []const u8,

    /// The tags to add to the resource.
    tag_list: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_list = "TagList",
    };
};
