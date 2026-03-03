const RouteVehicleArrival = @import("route_vehicle_arrival.zig").RouteVehicleArrival;
const RouteVehicleDeparture = @import("route_vehicle_departure.zig").RouteVehicleDeparture;
const RouteVehicleIncident = @import("route_vehicle_incident.zig").RouteVehicleIncident;
const RouteVehicleNotice = @import("route_vehicle_notice.zig").RouteVehicleNotice;
const RoutePassThroughWaypoint = @import("route_pass_through_waypoint.zig").RoutePassThroughWaypoint;
const RouteVehicleSpan = @import("route_vehicle_span.zig").RouteVehicleSpan;
const RouteVehicleSummary = @import("route_vehicle_summary.zig").RouteVehicleSummary;
const RouteToll = @import("route_toll.zig").RouteToll;
const RouteTollSystem = @import("route_toll_system.zig").RouteTollSystem;
const RouteVehicleTravelStep = @import("route_vehicle_travel_step.zig").RouteVehicleTravelStep;
const RouteZone = @import("route_zone.zig").RouteZone;

/// Steps of a leg that correspond to the travel portion of the leg.
pub const RouteVehicleLegDetails = struct {
    /// Details corresponding to the arrival for the leg.
    arrival: RouteVehicleArrival,

    /// Details corresponding to the departure for the leg.
    departure: RouteVehicleDeparture,

    /// Incidents corresponding to this leg of the route.
    incidents: []const RouteVehicleIncident,

    /// Notices are additional information returned that indicate issues that
    /// occurred during route calculation.
    notices: []const RouteVehicleNotice,

    /// Waypoints that were passed through during the leg. This includes the
    /// waypoints that were configured with the PassThrough option.
    pass_through_waypoints: []const RoutePassThroughWaypoint,

    /// Spans that were computed for the requested SpanAdditionalFeatures.
    spans: []const RouteVehicleSpan,

    /// Summarized details of the leg.
    summary: ?RouteVehicleSummary = null,

    /// Toll related options.
    tolls: []const RouteToll,

    /// Toll systems are authorities that collect payments for the toll.
    toll_systems: []const RouteTollSystem,

    /// Steps of a leg that must be performed before the travel portion of the leg.
    travel_steps: []const RouteVehicleTravelStep,

    /// Truck road type identifiers. `BK1` through `BK4` apply only to Sweden.
    /// `A2,A4,B2,B4,C,D,ET2,ET4` apply only to Mexico.
    ///
    /// There are currently no other supported values as of 26th April 2024.
    truck_road_types: []const []const u8,

    /// Zones corresponding to this leg of the route.
    zones: []const RouteZone,

    pub const json_field_names = .{
        .arrival = "Arrival",
        .departure = "Departure",
        .incidents = "Incidents",
        .notices = "Notices",
        .pass_through_waypoints = "PassThroughWaypoints",
        .spans = "Spans",
        .summary = "Summary",
        .tolls = "Tolls",
        .toll_systems = "TollSystems",
        .travel_steps = "TravelSteps",
        .truck_road_types = "TruckRoadTypes",
        .zones = "Zones",
    };
};
