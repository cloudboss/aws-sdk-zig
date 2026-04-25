/// Geometry defined as a circle. When request routing boundary was set as
/// `AutoCircle`, the response routing boundary will return `Circle` derived
/// from the `AutoCircle` settings.
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
    radius: f64,

    pub const json_field_names = .{
        .center = "Center",
        .radius = "Radius",
    };
};
