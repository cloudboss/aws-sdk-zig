/// Time breakdown for the sequence.
pub const WaypointOptimizationTimeBreakdown = struct {
    /// Resting phase of the cycle.
    ///
    /// **Unit**: `seconds`
    rest_duration: i64 = 0,

    /// Service time spent at the destination. At an appointment, the service time
    /// should be the appointment duration.
    ///
    /// **Unit**: `seconds`
    service_duration: i64 = 0,

    /// Traveling phase of the cycle.
    ///
    /// **Unit**: `seconds`
    travel_duration: i64 = 0,

    /// Waiting phase of the cycle.
    ///
    /// **Unit**: `seconds`
    wait_duration: i64 = 0,

    pub const json_field_names = .{
        .rest_duration = "RestDuration",
        .service_duration = "ServiceDuration",
        .travel_duration = "TravelDuration",
        .wait_duration = "WaitDuration",
    };
};
