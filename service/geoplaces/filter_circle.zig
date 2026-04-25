/// The `Circle` that all results must be in.
pub const FilterCircle = struct {
    /// The center position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    center: []const f64,

    /// The radius, in meters, of the `FilterCircle`. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers,`ap-southeast-1` and `ap-southeast-5` regions support only up to a maximum value of 300,000.
    radius: i64,

    pub const json_field_names = .{
        .center = "Center",
        .radius = "Radius",
    };
};
