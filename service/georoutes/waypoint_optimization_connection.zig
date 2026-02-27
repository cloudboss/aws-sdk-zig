/// This contains information such as distance and duration from one waypoint to
/// the next waypoint in the sequence.
pub const WaypointOptimizationConnection = struct {
    /// Distance of the step.
    distance: i64 = 0,

    /// contains the ID of the starting waypoint in this connection.
    from: []const u8,

    /// Resting time before the driver can continue driving.
    rest_duration: i64 = 0,

    /// Contains the ID of the ending waypoint in this connection.
    to: []const u8,

    /// Total duration.
    ///
    /// **Unit**: `seconds`
    travel_duration: i64 = 0,

    /// Duration of a wait step.
    ///
    /// **Unit**: `seconds`
    wait_duration: i64 = 0,

    pub const json_field_names = .{
        .distance = "Distance",
        .from = "From",
        .rest_duration = "RestDuration",
        .to = "To",
        .travel_duration = "TravelDuration",
        .wait_duration = "WaitDuration",
    };
};
