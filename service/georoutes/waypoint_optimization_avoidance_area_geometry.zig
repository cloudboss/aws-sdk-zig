/// Geometry of the area to be avoided.
pub const WaypointOptimizationAvoidanceAreaGeometry = struct {
    /// Geometry defined as a bounding box. The first pair represents the X and Y
    /// coordinates (longitude and latitude,) of the southwest corner of the
    /// bounding box; the second pair represents the X and Y coordinates (longitude
    /// and latitude) of the northeast corner.
    bounding_box: ?[]const f64,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
    };
};
