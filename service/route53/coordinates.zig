/// A complex type that lists the coordinates for a geoproximity resource
/// record.
pub const Coordinates = struct {
    /// Specifies a coordinate of the north–south position of a geographic point on
    /// the surface of
    /// the Earth (-90 - 90).
    latitude: []const u8,

    /// Specifies a coordinate of the east–west position of a geographic point on
    /// the surface of
    /// the Earth (-180 - 180).
    longitude: []const u8,
};
