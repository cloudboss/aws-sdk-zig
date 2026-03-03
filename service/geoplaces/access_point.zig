/// Position of the access point represented by longitude and latitude for a
/// vehicle.
pub const AccessPoint = struct {
    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64 = null,

    pub const json_field_names = .{
        .position = "Position",
    };
};
