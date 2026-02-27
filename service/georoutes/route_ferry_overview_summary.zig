/// Summarized details of the leg.
pub const RouteFerryOverviewSummary = struct {
    /// Distance of the step.
    distance: i64 = 0,

    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration = "Duration",
    };
};
