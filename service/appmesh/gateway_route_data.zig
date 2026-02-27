const ResourceMetadata = @import("resource_metadata.zig").ResourceMetadata;
const GatewayRouteSpec = @import("gateway_route_spec.zig").GatewayRouteSpec;
const GatewayRouteStatus = @import("gateway_route_status.zig").GatewayRouteStatus;

/// An object that represents a gateway route returned by a describe operation.
pub const GatewayRouteData = struct {
    /// The name of the gateway route.
    gateway_route_name: []const u8,

    /// The name of the service mesh that the resource resides in.
    mesh_name: []const u8,

    metadata: ResourceMetadata,

    /// The specifications of the gateway route.
    spec: GatewayRouteSpec,

    /// The status of the gateway route.
    status: GatewayRouteStatus,

    /// The virtual gateway that the gateway route is associated with.
    virtual_gateway_name: []const u8,

    pub const json_field_names = .{
        .gateway_route_name = "gatewayRouteName",
        .mesh_name = "meshName",
        .metadata = "metadata",
        .spec = "spec",
        .status = "status",
        .virtual_gateway_name = "virtualGatewayName",
    };
};
