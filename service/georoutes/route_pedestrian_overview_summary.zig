/// Summary including duration and distance for the entire leg.
pub const RoutePedestrianOverviewSummary = struct {
    /// Distance of the entire leg.
    ///
    /// **Unit**: `meters`
    distance: i64 = 0,

    /// Duration of the entire leg.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration = "Duration",
    };
};
