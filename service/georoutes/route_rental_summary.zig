const RouteRentalOverviewSummary = @import("route_rental_overview_summary.zig").RouteRentalOverviewSummary;
const RouteRentalTravelOnlySummary = @import("route_rental_travel_only_summary.zig").RouteRentalTravelOnlySummary;

/// Summary of the rental leg.
pub const RouteRentalSummary = struct {
    /// Summary including duration and distance for the entire leg.
    overview: ?RouteRentalOverviewSummary = null,

    /// Summary including duration and distance for the travel portion of the leg
    /// only.
    travel_only: ?RouteRentalTravelOnlySummary = null,

    pub const json_field_names = .{
        .overview = "Overview",
        .travel_only = "TravelOnly",
    };
};
