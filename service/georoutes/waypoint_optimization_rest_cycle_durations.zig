/// Driver work-rest schedules defined by a short and long cycle. A rest needs
/// to be taken after the short work duration. The short cycle can be repeated
/// until you hit the long work duration, at which point the long rest duration
/// should be taken before restarting.
///
/// **Unit**: `seconds`
pub const WaypointOptimizationRestCycleDurations = struct {
    /// Resting phase of the cycle.
    ///
    /// **Unit**: `seconds`
    rest_duration: i64 = 0,

    /// Working phase of the cycle.
    ///
    /// **Unit**: `seconds`
    work_duration: i64 = 0,

    pub const json_field_names = .{
        .rest_duration = "RestDuration",
        .work_duration = "WorkDuration",
    };
};
