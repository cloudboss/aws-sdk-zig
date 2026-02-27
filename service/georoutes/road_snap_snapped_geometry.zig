/// Interpolated geometry for the snapped route that is overlay-able onto a map.
pub const RoadSnapSnappedGeometry = struct {
    /// An ordered list of positions used to plot a route on a map.
    ///
    /// LineString and Polyline are mutually exclusive properties.
    line_string: ?[]const []const f64,

    /// An ordered list of positions used to plot a route on a map in a lossy
    /// compression format.
    ///
    /// LineString and Polyline are mutually exclusive properties.
    polyline: ?[]const u8,

    pub const json_field_names = .{
        .line_string = "LineString",
        .polyline = "Polyline",
    };
};
