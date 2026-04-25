/// Details about the dynamic speed.
///
/// **Unit**: `kilometers per hour`
pub const RouteSpanDynamicSpeedDetails = struct {
    /// Estimated speed while traversing the span without traffic congestion.
    ///
    /// **Unit**: `kilometers per hour`
    best_case_speed: f64 = 0,

    /// Estimated time to turn from this span into the next.
    ///
    /// **Unit**: `seconds`
    turn_duration: i64 = 0,

    /// Estimated speed while traversing the span under typical traffic congestion.
    ///
    /// **Unit**: `kilometers per hour`
    typical_speed: f64 = 0,

    pub const json_field_names = .{
        .best_case_speed = "BestCaseSpeed",
        .turn_duration = "TurnDuration",
        .typical_speed = "TypicalSpeed",
    };
};
