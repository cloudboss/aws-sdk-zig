const RouteTaxiOverviewSummary = @import("route_taxi_overview_summary.zig").RouteTaxiOverviewSummary;
const RouteTaxiTravelOnlySummary = @import("route_taxi_travel_only_summary.zig").RouteTaxiTravelOnlySummary;

/// Summary of the taxi leg.
pub const RouteTaxiSummary = struct {
    /// Summary including duration and distance for the entire leg.
    overview: ?RouteTaxiOverviewSummary = null,

    /// Summary including duration and distance for the travel portion of the leg
    /// only.
    travel_only: ?RouteTaxiTravelOnlySummary = null,

    pub const json_field_names = .{
        .overview = "Overview",
        .travel_only = "TravelOnly",
    };
};
