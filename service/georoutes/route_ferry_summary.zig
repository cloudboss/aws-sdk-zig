const RouteFerryOverviewSummary = @import("route_ferry_overview_summary.zig").RouteFerryOverviewSummary;
const RouteFerryTravelOnlySummary = @import("route_ferry_travel_only_summary.zig").RouteFerryTravelOnlySummary;

/// Summarized details for the leg including travel steps only. The Distance for
/// the travel only portion of the journey is the same as the Distance within
/// the Overview summary.
pub const RouteFerrySummary = struct {
    /// Summarized details for the leg including before travel, travel and after
    /// travel steps.
    overview: ?RouteFerryOverviewSummary,

    /// Summarized details for the leg including travel steps only. The Distance for
    /// the travel only portion of the journey is in meters
    travel_only: ?RouteFerryTravelOnlySummary,

    pub const json_field_names = .{
        .overview = "Overview",
        .travel_only = "TravelOnly",
    };
};
