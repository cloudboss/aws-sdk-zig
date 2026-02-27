const ResourceMetadata = @import("resource_metadata.zig").ResourceMetadata;
const RouteSpec = @import("route_spec.zig").RouteSpec;
const RouteStatus = @import("route_status.zig").RouteStatus;

/// An object that represents a route returned by a describe operation.
pub const RouteData = struct {
    /// The name of the service mesh that the route resides in.
    mesh_name: []const u8,

    /// The associated metadata for the route.
    metadata: ResourceMetadata,

    /// The name of the route.
    route_name: []const u8,

    /// The specifications of the route.
    spec: RouteSpec,

    /// The status of the route.
    status: RouteStatus,

    /// The virtual router that the route is associated with.
    virtual_router_name: []const u8,

    pub const json_field_names = .{
        .mesh_name = "meshName",
        .metadata = "metadata",
        .route_name = "routeName",
        .spec = "spec",
        .status = "status",
        .virtual_router_name = "virtualRouterName",
    };
};
