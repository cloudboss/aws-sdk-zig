const ResourceTypeEnum = @import("resource_type_enum.zig").ResourceTypeEnum;
const Tag = @import("tag.zig").Tag;

/// Defines tagging configuration for a resource.
pub const TagSpecification = struct {
    /// Type of resource being tagged.
    resource_type: ?ResourceTypeEnum = null,

    /// Collection of tags for the specified resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};
