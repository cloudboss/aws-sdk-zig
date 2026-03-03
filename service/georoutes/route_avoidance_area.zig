const RouteAvoidanceAreaGeometry = @import("route_avoidance_area_geometry.zig").RouteAvoidanceAreaGeometry;

/// Areas to be avoided.
pub const RouteAvoidanceArea = struct {
    /// Exceptions to the provided avoidance geometry, to be included while
    /// calculating the route.
    except: ?[]const RouteAvoidanceAreaGeometry = null,

    geometry: RouteAvoidanceAreaGeometry,

    pub const json_field_names = .{
        .except = "Except",
        .geometry = "Geometry",
    };
};
