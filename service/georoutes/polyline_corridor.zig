/// Geometry defined as an encoded corridor - an encoded polyline with a radius
/// that defines the width of the corridor.
pub const PolylineCorridor = struct {
    /// An ordered list of positions used to plot a route on a map in a lossy
    /// compression format.
    ///
    /// LineString and Polyline are mutually exclusive properties.
    polyline: []const u8,

    /// Considers all roads within the provided radius to match the provided
    /// destination to. The roads that are considered are determined by the provided
    /// Strategy.
    ///
    /// **Unit**: `meters`
    radius: i32,

    pub const json_field_names = .{
        .polyline = "Polyline",
        .radius = "Radius",
    };
};
