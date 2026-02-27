/// Provides a summary of a pedestrian route step.
pub const RoutePedestrianOverviewSummary = struct {
    /// Distance of the step.
    distance: i64 = 0,

    /// Duration of the step.
    duration: i64 = 0,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration = "Duration",
    };
};
