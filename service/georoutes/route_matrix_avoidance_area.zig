const RouteMatrixAvoidanceAreaGeometry = @import("route_matrix_avoidance_area_geometry.zig").RouteMatrixAvoidanceAreaGeometry;

/// Area to be avoided.
pub const RouteMatrixAvoidanceArea = struct {
    /// Geometry of the area to be avoided.
    geometry: RouteMatrixAvoidanceAreaGeometry,

    pub const json_field_names = .{
        .geometry = "Geometry",
    };
};
