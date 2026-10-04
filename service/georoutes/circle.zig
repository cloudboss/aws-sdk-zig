/// Geometry defined as a circle. The circle defines the routing boundary area.
/// Any waypoints outside the circle will result in a route matrix entry error.
///
/// You can specify a `Circle` directly in the request, or it will be
/// auto-derived when `AutoCircle` is used. When `AutoCircle` is set in the
/// request, the response routing boundary will return `Circle` derived from the
/// `AutoCircle` settings.
pub const Circle = struct {
    /// Center of the Circle in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    ///
    /// Example: `[-123.1174, 49.2847]` represents the position with longitude
    /// `-123.1174` and latitude `49.2847`.
    center: []const f64,

    /// Radius of the Circle.
    ///
    /// **Unit**: `meters`
    ///
    /// Valid Range: Minimum value of 0. Maximum value of 200000.
    radius: f64,

    pub const json_field_names = .{
        .center = "Center",
        .radius = "Radius",
    };
};
