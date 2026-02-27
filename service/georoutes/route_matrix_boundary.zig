const RouteMatrixBoundaryGeometry = @import("route_matrix_boundary_geometry.zig").RouteMatrixBoundaryGeometry;

/// Boundary within which the matrix is to be calculated. All data, origins and
/// destinations outside the boundary are considered invalid.
pub const RouteMatrixBoundary = struct {
    /// Geometry of the area to be avoided.
    geometry: ?RouteMatrixBoundaryGeometry,

    /// No restrictions in terms of a routing boundary, and is typically used for
    /// longer routes.
    unbounded: ?bool,

    pub const json_field_names = .{
        .geometry = "Geometry",
        .unbounded = "Unbounded",
    };
};
