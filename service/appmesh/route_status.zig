const RouteStatusCode = @import("route_status_code.zig").RouteStatusCode;

/// An object that represents the current status of a route.
pub const RouteStatus = struct {
    /// The current status for the route.
    status: RouteStatusCode,

    pub const json_field_names = .{
        .status = "status",
    };
};
