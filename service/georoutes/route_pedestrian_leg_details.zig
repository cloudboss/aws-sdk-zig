const RoutePedestrianArrival = @import("route_pedestrian_arrival.zig").RoutePedestrianArrival;
const RoutePedestrianDeparture = @import("route_pedestrian_departure.zig").RoutePedestrianDeparture;
const RoutePedestrianNotice = @import("route_pedestrian_notice.zig").RoutePedestrianNotice;
const RoutePassThroughWaypoint = @import("route_pass_through_waypoint.zig").RoutePassThroughWaypoint;
const RoutePedestrianSpan = @import("route_pedestrian_span.zig").RoutePedestrianSpan;
const RoutePedestrianSummary = @import("route_pedestrian_summary.zig").RoutePedestrianSummary;
const RoutePedestrianTravelStep = @import("route_pedestrian_travel_step.zig").RoutePedestrianTravelStep;

/// Details that are specific to a pedestrian leg.
pub const RoutePedestrianLegDetails = struct {
    /// Details corresponding to the arrival for the leg.
    arrival: RoutePedestrianArrival,

    /// Details corresponding to the departure for the leg.
    departure: RoutePedestrianDeparture,

    /// Notices are additional information returned that indicate issues that
    /// occurred during route calculation.
    notices: []const RoutePedestrianNotice,

    /// Waypoints that were passed through during the leg. This includes the
    /// waypoints that were configured with the PassThrough option.
    pass_through_waypoints: []const RoutePassThroughWaypoint,

    /// Spans that were computed for the requested SpanAdditionalFeatures.
    spans: []const RoutePedestrianSpan,

    /// Summarized details of the leg.
    summary: ?RoutePedestrianSummary = null,

    /// Steps of a leg that must be performed before the travel portion of the leg.
    travel_steps: []const RoutePedestrianTravelStep,

    pub const json_field_names = .{
        .arrival = "Arrival",
        .departure = "Departure",
        .notices = "Notices",
        .pass_through_waypoints = "PassThroughWaypoints",
        .spans = "Spans",
        .summary = "Summary",
        .travel_steps = "TravelSteps",
    };
};
