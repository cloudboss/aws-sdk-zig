/// Summarized details of the route.
pub const RouteVehicleTravelOnlySummary = struct {
    /// Total duration in free flowing traffic, which is the best case or shortest
    /// duration possible to cover the leg.
    ///
    /// **Unit**: `seconds`
    best_case_duration: i64 = 0,

    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Duration of the computed span under typical traffic congestion.
    ///
    /// **Unit**: `seconds`
    typical_duration: i64 = 0,

    pub const json_field_names = .{
        .best_case_duration = "BestCaseDuration",
        .duration = "Duration",
        .typical_duration = "TypicalDuration",
    };
};
