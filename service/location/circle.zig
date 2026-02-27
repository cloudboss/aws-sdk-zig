/// A circle on the earth, as defined by a center point and a radius.
pub const Circle = struct {
    /// A single point geometry, specifying the center of the circle, using [WGS
    /// 84](https://gisgeography.com/wgs84-world-geodetic-system/) coordinates, in
    /// the form `[longitude, latitude]`.
    center: []const f64,

    /// The radius of the circle in meters. Must be greater than zero and no larger
    /// than 100,000 (100 kilometers).
    radius: f64,

    pub const json_field_names = .{
        .center = "Center",
        .radius = "Radius",
    };
};
