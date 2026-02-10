const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes a tag.
pub const TagDescription = struct {
    /// The tag key.
    key: ?[]const u8,

    /// The ID of the resource.
    resource_id: ?[]const u8,

    /// The resource type.
    resource_type: ?ResourceType,

    /// The tag value.
    value: ?[]const u8,
};
