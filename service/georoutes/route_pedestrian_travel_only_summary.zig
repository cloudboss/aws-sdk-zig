/// Summarized details for the leg including travel steps.
pub const RoutePedestrianTravelOnlySummary = struct {
    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    pub const json_field_names = .{
        .duration = "Duration",
    };
};
