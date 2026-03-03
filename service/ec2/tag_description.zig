const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes a tag.
pub const TagDescription = struct {
    /// The tag key.
    key: ?[]const u8 = null,

    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The resource type.
    resource_type: ?ResourceType = null,

    /// The tag value.
    value: ?[]const u8 = null,
};
