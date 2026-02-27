/// Geometry defined as a corridor - a LineString with a radius that defines the
/// width of the corridor.
pub const Corridor = struct {
    /// An ordered list of positions used to plot a route on a map.
    ///
    /// LineString and Polyline are mutually exclusive properties.
    line_string: []const []const f64,

    /// Radius that defines the width of the corridor.
    radius: i32,

    pub const json_field_names = .{
        .line_string = "LineString",
        .radius = "Radius",
    };
};
