const RouteMatrixAutoCircle = @import("route_matrix_auto_circle.zig").RouteMatrixAutoCircle;
const Circle = @import("circle.zig").Circle;

/// Geometry of the routing boundary.
pub const RouteMatrixBoundaryGeometry = struct {
    /// Provides the circle that was used while calculating the route.
    auto_circle: ?RouteMatrixAutoCircle = null,

    /// Geometry defined as a bounding box. The first pair represents the X and Y
    /// coordinates (longitude and latitude,) of the southwest corner of the
    /// bounding box; the second pair represents the X and Y coordinates (longitude
    /// and latitude) of the northeast corner.
    bounding_box: ?[]const f64 = null,

    /// Geometry defined as a circle. When request routing boundary was set as
    /// `AutoCircle`, the response routing boundary will return `Circle` derived
    /// from the `AutoCircle` settings.
    circle: ?Circle = null,

    /// Geometry defined as a polygon with only one linear ring.
    polygon: ?[]const []const []const f64 = null,

    pub const json_field_names = .{
        .auto_circle = "AutoCircle",
        .bounding_box = "BoundingBox",
        .circle = "Circle",
        .polygon = "Polygon",
    };
};
