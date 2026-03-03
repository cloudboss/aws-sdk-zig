/// The device's position and speed.
pub const ForecastGeofenceEventsDeviceState = struct {
    /// The device's position.
    position: []const f64,

    /// The device's speed.
    speed: ?f64 = null,

    pub const json_field_names = .{
        .position = "Position",
        .speed = "Speed",
    };
};
