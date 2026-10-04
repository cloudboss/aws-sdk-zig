/// Summary including duration and distance for the entire leg.
pub const RouteVehicleOverviewSummary = struct {
    /// Total duration in free flowing traffic, which is the best case or shortest
    /// duration possible to cover the leg.
    ///
    /// **Unit**: `seconds`
    best_case_duration: i64 = 0,

    /// Distance of the entire leg.
    ///
    /// **Unit**: `meters`
    distance: i64 = 0,

    /// Duration of the entire leg.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Duration of the leg under typical traffic congestion.
    ///
    /// **Unit**: `seconds`
    typical_duration: i64 = 0,

    pub const json_field_names = .{
        .best_case_duration = "BestCaseDuration",
        .distance = "Distance",
        .duration = "Duration",
        .typical_duration = "TypicalDuration",
    };
};
