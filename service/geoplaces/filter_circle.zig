/// The `Circle` that all results must be in.
pub const FilterCircle = struct {
    /// The center position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    center: []const f64,

    /// The radius, in meters, of the `FilterCircle`.
    radius: i64,

    pub const json_field_names = .{
        .center = "Center",
        .radius = "Radius",
    };
};
