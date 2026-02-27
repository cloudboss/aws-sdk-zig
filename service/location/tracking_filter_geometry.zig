/// The geomerty used to filter device positions.
pub const TrackingFilterGeometry = struct {
    /// The set of arrays which define the polygon. A polygon can have between 4 and
    /// 1000 vertices.
    polygon: ?[]const []const []const f64,

    pub const json_field_names = .{
        .polygon = "Polygon",
    };
};
