const ResourceType = @import("resource_type.zig").ResourceType;

/// The details that identify a resource within Config, including
/// the resource type and resource ID.
pub const ResourceKey = struct {
    /// The ID of the resource (for example., sg-xxxxxx).
    resource_id: []const u8,

    /// The resource type.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};
