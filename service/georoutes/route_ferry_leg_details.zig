const RouteFerryAfterTravelStep = @import("route_ferry_after_travel_step.zig").RouteFerryAfterTravelStep;
const RouteFerryArrival = @import("route_ferry_arrival.zig").RouteFerryArrival;
const RouteFerryBeforeTravelStep = @import("route_ferry_before_travel_step.zig").RouteFerryBeforeTravelStep;
const RouteFerryDeparture = @import("route_ferry_departure.zig").RouteFerryDeparture;
const RouteFerryNotice = @import("route_ferry_notice.zig").RouteFerryNotice;
const RoutePassThroughWaypoint = @import("route_pass_through_waypoint.zig").RoutePassThroughWaypoint;
const RouteFerrySpan = @import("route_ferry_span.zig").RouteFerrySpan;
const RouteFerrySummary = @import("route_ferry_summary.zig").RouteFerrySummary;
const RouteFerryTravelStep = @import("route_ferry_travel_step.zig").RouteFerryTravelStep;

/// FerryLegDetails is populated when the Leg type is Ferry, and provides
/// additional information that is specific
pub const RouteFerryLegDetails = struct {
    /// Steps of a leg that must be performed after the travel portion of the leg.
    after_travel_steps: []const RouteFerryAfterTravelStep,

    /// Details corresponding to the arrival for the leg.
    arrival: RouteFerryArrival,

    /// Steps of a leg that must be performed before the travel portion of the leg.
    before_travel_steps: []const RouteFerryBeforeTravelStep,

    /// Details corresponding to the departure for the leg.
    departure: RouteFerryDeparture,

    /// Notices are additional information returned that indicate issues that
    /// occurred during route calculation.
    notices: []const RouteFerryNotice,

    /// Waypoints that were passed through during the leg. This includes the
    /// waypoints that were configured with the PassThrough option.
    pass_through_waypoints: []const RoutePassThroughWaypoint,

    /// Route name of the ferry line.
    route_name: ?[]const u8 = null,

    /// Spans that were computed for the requested SpanAdditionalFeatures.
    spans: []const RouteFerrySpan,

    /// Summarized details of the leg.
    summary: ?RouteFerrySummary = null,

    /// Steps of a leg that must be performed before the travel portion of the leg.
    travel_steps: []const RouteFerryTravelStep,

    pub const json_field_names = .{
        .after_travel_steps = "AfterTravelSteps",
        .arrival = "Arrival",
        .before_travel_steps = "BeforeTravelSteps",
        .departure = "Departure",
        .notices = "Notices",
        .pass_through_waypoints = "PassThroughWaypoints",
        .route_name = "RouteName",
        .spans = "Spans",
        .summary = "Summary",
        .travel_steps = "TravelSteps",
    };
};
