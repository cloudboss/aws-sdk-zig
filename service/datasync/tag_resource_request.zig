const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

/// TagResourceRequest
pub const TagResourceRequest = struct {
    /// Specifies the Amazon Resource Name (ARN) of the resource to apply the tag
    /// to.
    resource_arn: []const u8,

    /// Specifies the tags that you want to apply to the resource.
    tags: []const TagListEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
