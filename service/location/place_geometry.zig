/// Places uses a point geometry to specify a location or a Place.
pub const PlaceGeometry = struct {
    /// A single point geometry specifies a location for a Place using [WGS
    /// 84](https://gisgeography.com/wgs84-world-geodetic-system/) coordinates:
    ///
    /// * *x* — Specifies the x coordinate or longitude.
    /// * *y* — Specifies the y coordinate or latitude.
    point: ?[]const f64,

    pub const json_field_names = .{
        .point = "Point",
    };
};
