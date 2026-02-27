const ResourceCollection = @import("resource_collection.zig").ResourceCollection;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;

/// Information about the resource that is being monitored, including the name
/// of the resource, the type of resource, and whether or not permission is
/// given to DevOps Guru to access that resource.
pub const MonitoredResourceIdentifier = struct {
    /// The time at which DevOps Guru last updated this resource.
    last_updated: ?i64,

    /// The name of the resource being monitored.
    monitored_resource_name: ?[]const u8,

    resource_collection: ?ResourceCollection,

    /// The permission status of a resource.
    resource_permission: ?ResourcePermission,

    /// The type of resource being monitored.
    type: ?[]const u8,

    pub const json_field_names = .{
        .last_updated = "LastUpdated",
        .monitored_resource_name = "MonitoredResourceName",
        .resource_collection = "ResourceCollection",
        .resource_permission = "ResourcePermission",
        .type = "Type",
    };
};
