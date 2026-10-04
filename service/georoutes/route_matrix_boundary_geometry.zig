const RouteMatrixAutoCircle = @import("route_matrix_auto_circle.zig").RouteMatrixAutoCircle;
const Circle = @import("circle.zig").Circle;

/// Geometry of the routing boundary.
pub const RouteMatrixBoundaryGeometry = struct {
    /// `AutoCircle` requests the route matrix service to define a `Circle` boundary
    /// that best attempts to include most waypoints (`Origins` and `Destinations`)
    /// using the `AutoCircle` settings. Any waypoints outside of the auto-defined
    /// `Circle` boundary will be considered out of the routing boundary, which
    /// results in a route matrix entry error.
    ///
    /// `AutoCircle` is only used in the request to configure a `Circle` for the
    /// route calculation. The derived `Circle` will also be provided in the
    /// response.
    auto_circle: ?RouteMatrixAutoCircle = null,

    /// Geometry defined as a bounding box. The first pair represents the X and Y
    /// coordinates (longitude and latitude,) of the southwest corner of the
    /// bounding box; the second pair represents the X and Y coordinates (longitude
    /// and latitude) of the northeast corner.
    ///
    /// Diagonal distance of the bounding box must be less than or equal to 400,000
    /// meters.
    bounding_box: ?[]const f64 = null,

    /// Geometry defined as a circle. The circle defines the routing boundary area.
    /// Any waypoints outside the circle will result in a route matrix entry error.
    ///
    /// You can specify a `Circle` directly in the request, or it will be
    /// auto-derived when `AutoCircle` is used. When `AutoCircle` is set in the
    /// request, the response routing boundary will return `Circle` derived from the
    /// `AutoCircle` settings.
    circle: ?Circle = null,

    /// Geometry defined as a polygon with only one linear ring. A linear ring is a
    /// closed sequence of four or more coordinates. The first and last coordinates
    /// are the same, forming a closed boundary. Each coordinate is a position in
    /// [longitude, latitude] format.
    ///
    /// The structure is an array of linear rings (only 1 allowed). Each linear ring
    /// is an array of coordinates (minimum 4), and each coordinate is an array of
    /// two doubles [longitude, latitude].
    ///
    /// Maximum distance between any two vertices must be less than or equal to
    /// 400,000 meters.
    polygon: ?[]const []const []const f64 = null,

    pub const json_field_names = .{
        .auto_circle = "AutoCircle",
        .bounding_box = "BoundingBox",
        .circle = "Circle",
        .polygon = "Polygon",
    };
};
