/// The geospatial radius for a circle.
pub const GeospatialCircleRadius = struct {
    /// The positive value for the radius of a circle.
    radius: ?f64,

    pub const json_field_names = .{
        .radius = "Radius",
    };
};
