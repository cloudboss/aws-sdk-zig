/// TracePoint indices for which the provided notice code corresponds to.
pub const RoadSnapTracePoint = struct {
    /// GPS Heading at the position.
    heading: f64 = 0,

    /// Position defined as `[longitude, latitude]`.
    position: []const f64,

    /// Speed at the specified trace point .
    ///
    /// **Unit**: `KilometersPerHour`
    speed: f64 = 0,

    /// Timestamp of the event.
    timestamp: ?[]const u8 = null,

    pub const json_field_names = .{
        .heading = "Heading",
        .position = "Position",
        .speed = "Speed",
        .timestamp = "Timestamp",
    };
};
