const RouteTransitOverviewSummary = @import("route_transit_overview_summary.zig").RouteTransitOverviewSummary;
const RouteTransitTravelOnlySummary = @import("route_transit_travel_only_summary.zig").RouteTransitTravelOnlySummary;

/// Summary of the transit leg.
pub const RouteTransitSummary = struct {
    /// Summary including duration and distance for the entire leg.
    overview: ?RouteTransitOverviewSummary = null,

    /// Summary including duration and distance for the travel portion of the leg
    /// only.
    travel_only: ?RouteTransitTravelOnlySummary = null,

    pub const json_field_names = .{
        .overview = "Overview",
        .travel_only = "TravelOnly",
    };
};
