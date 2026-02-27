const ResourceType = @import("resource_type.zig").ResourceType;

/// The details that identify a resource that is discovered by Config, including
/// the resource type, ID, and (if available) the
/// custom resource name.
pub const ResourceIdentifier = struct {
    /// The time that the resource was deleted.
    resource_deletion_time: ?i64,

    /// The ID of the resource (for example,
    /// `sg-xxxxxx`).
    resource_id: ?[]const u8,

    /// The custom name of the resource (if available).
    resource_name: ?[]const u8,

    /// The type of resource.
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .resource_deletion_time = "resourceDeletionTime",
        .resource_id = "resourceId",
        .resource_name = "resourceName",
        .resource_type = "resourceType",
    };
};
