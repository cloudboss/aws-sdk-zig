const RoutePedestrianOverviewSummary = @import("route_pedestrian_overview_summary.zig").RoutePedestrianOverviewSummary;
const RoutePedestrianTravelOnlySummary = @import("route_pedestrian_travel_only_summary.zig").RoutePedestrianTravelOnlySummary;

/// Summarized details for the leg including before travel, travel and after
/// travel steps.
pub const RoutePedestrianSummary = struct {
    /// Summarized details for the leg including before travel, travel and after
    /// travel steps.
    overview: ?RoutePedestrianOverviewSummary = null,

    /// Summarized details for the leg including travel steps only. The Distance for
    /// the travel only portion of the journey is in meters
    travel_only: ?RoutePedestrianTravelOnlySummary = null,

    pub const json_field_names = .{
        .overview = "Overview",
        .travel_only = "TravelOnly",
    };
};
