const RouteDetails = @import("route_details.zig").RouteDetails;

/// An object that contains configuration details of multi-region endpoint
/// (global-endpoint).
pub const Details = struct {
    /// A list of route configuration details. Must contain exactly one route
    /// configuration.
    routes_details: []const RouteDetails,

    pub const json_field_names = .{
        .routes_details = "RoutesDetails",
    };
};
