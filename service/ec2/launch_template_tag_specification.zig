const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// The tags specification for the launch template.
pub const LaunchTemplateTagSpecification = struct {
    /// The type of resource to tag.
    resource_type: ?ResourceType,

    /// The tags for the resource.
    tags: ?[]const Tag,
};
