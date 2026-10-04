/// Summary including duration and distance for the travel portion of the leg
/// only.
pub const RouteRentalTravelOnlySummary = struct {
    /// Duration of the travel portion of the rental leg.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    pub const json_field_names = .{
        .duration = "Duration",
    };
};
