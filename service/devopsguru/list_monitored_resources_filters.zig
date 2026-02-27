const ResourcePermission = @import("resource_permission.zig").ResourcePermission;
const ResourceTypeFilter = @import("resource_type_filter.zig").ResourceTypeFilter;

/// Filters to determine which monitored resources you want to retrieve. You can
/// filter by resource type or resource permission status.
pub const ListMonitoredResourcesFilters = struct {
    /// The permission status of a resource.
    resource_permission: ResourcePermission,

    /// The type of resource that you wish to retrieve, such as log groups.
    resource_type_filters: []const ResourceTypeFilter,

    pub const json_field_names = .{
        .resource_permission = "ResourcePermission",
        .resource_type_filters = "ResourceTypeFilters",
    };
};
