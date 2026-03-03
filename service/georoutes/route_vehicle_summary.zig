const RouteVehicleOverviewSummary = @import("route_vehicle_overview_summary.zig").RouteVehicleOverviewSummary;
const RouteVehicleTravelOnlySummary = @import("route_vehicle_travel_only_summary.zig").RouteVehicleTravelOnlySummary;

/// Summarized details of the route.
pub const RouteVehicleSummary = struct {
    /// Summarized details for the leg including before travel, travel and after
    /// travel steps.
    overview: ?RouteVehicleOverviewSummary = null,

    /// Summarized details for the leg including travel steps only. The Distance for
    /// the travel only portion of the journey is in meters
    travel_only: ?RouteVehicleTravelOnlySummary = null,

    pub const json_field_names = .{
        .overview = "Overview",
        .travel_only = "TravelOnly",
    };
};
