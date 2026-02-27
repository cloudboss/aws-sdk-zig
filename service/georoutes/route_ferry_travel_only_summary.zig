/// Summarized details for the leg including travel steps only. The Distance for
/// the travel only portion of the journey is the same as the Distance within
/// the Overview summary.
pub const RouteFerryTravelOnlySummary = struct {
    /// Total duration in free flowing traffic, which is the best case or shortest
    /// duration possible to cover the leg.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    pub const json_field_names = .{
        .duration = "Duration",
    };
};
