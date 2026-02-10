const RouteServerRouteInstallationStatus = @import("route_server_route_installation_status.zig").RouteServerRouteInstallationStatus;

/// Describes the installation status of a route in a route table.
pub const RouteServerRouteInstallationDetail = struct {
    /// The current installation status of the route in the route table.
    route_installation_status: ?RouteServerRouteInstallationStatus,

    /// The reason for the current installation status of the route.
    route_installation_status_reason: ?[]const u8,

    /// The ID of the route table where the route is being installed.
    route_table_id: ?[]const u8,
};
