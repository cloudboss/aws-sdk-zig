const RouteTransitAfterTravelStep = @import("route_transit_after_travel_step.zig").RouteTransitAfterTravelStep;
const RouteTransitAgency = @import("route_transit_agency.zig").RouteTransitAgency;
const RouteTransitArrival = @import("route_transit_arrival.zig").RouteTransitArrival;
const RouteAttribution = @import("route_attribution.zig").RouteAttribution;
const RouteTransitBeforeTravelStep = @import("route_transit_before_travel_step.zig").RouteTransitBeforeTravelStep;
const RouteWebLink = @import("route_web_link.zig").RouteWebLink;
const RouteTransitDeparture = @import("route_transit_departure.zig").RouteTransitDeparture;
const RouteTransitIncident = @import("route_transit_incident.zig").RouteTransitIncident;
const RouteTransitIntermediateStop = @import("route_transit_intermediate_stop.zig").RouteTransitIntermediateStop;
const RouteTransitNextDeparture = @import("route_transit_next_departure.zig").RouteTransitNextDeparture;
const RouteTransitNotice = @import("route_transit_notice.zig").RouteTransitNotice;
const RoutePassThroughWaypoint = @import("route_pass_through_waypoint.zig").RoutePassThroughWaypoint;
const RouteTransitSpan = @import("route_transit_span.zig").RouteTransitSpan;
const RouteTransitSummary = @import("route_transit_summary.zig").RouteTransitSummary;
const RouteTransitTransportModeDetails = @import("route_transit_transport_mode_details.zig").RouteTransitTransportModeDetails;
const RouteTransitTravelStep = @import("route_transit_travel_step.zig").RouteTransitTravelStep;

/// Populated when the Leg type is Transit, and provides additional information
/// that is specific to public transit travel.
pub const RouteTransitLegDetails = struct {
    /// Steps of a leg that must be performed after the travel portion of the leg.
    after_travel_steps: []const RouteTransitAfterTravelStep,

    /// Details about the transit agency.
    agency: ?RouteTransitAgency = null,

    /// Details corresponding to the arrival for the leg.
    arrival: RouteTransitArrival,

    /// List of required attributions to display.
    attributions: []const RouteAttribution,

    /// Steps of a leg that must be performed before the travel portion of the leg.
    before_travel_steps: []const RouteTransitBeforeTravelStep,

    /// Web links to external ticket booking services for the transit.
    booking_web_links: []const RouteWebLink,

    /// Details corresponding to the departure for the leg.
    departure: RouteTransitDeparture,

    /// Incidents affecting this leg of the transit route.
    incidents: []const RouteTransitIncident,

    /// Intermediate stops between departure and destination of the transit route.
    intermediate_stops: []const RouteTransitIntermediateStop,

    /// List of next departures that cover the same section of the route.
    next_departures: []const RouteTransitNextDeparture,

    /// List of notices that indicate issues that occurred during route calculation.
    notices: []const RouteTransitNotice,

    /// Waypoints that were passed through during the leg. This includes the
    /// waypoints that were configured with the PassThrough option. Not populated
    /// when the TravelMode is `Transit` or `Intermodal`.
    pass_through_waypoints: []const RoutePassThroughWaypoint,

    /// Spans that were computed for the requested SpanAdditionalFeatures. Not
    /// populated when the TravelMode is `Transit` or `Intermodal`.
    spans: []const RouteTransitSpan,

    /// Summary of the transit leg.
    summary: ?RouteTransitSummary = null,

    /// Transport mode details for the transit leg.
    transport: RouteTransitTransportModeDetails,

    /// Steps of a leg that must be performed during the travel portion of the leg.
    travel_steps: []const RouteTransitTravelStep,

    pub const json_field_names = .{
        .after_travel_steps = "AfterTravelSteps",
        .agency = "Agency",
        .arrival = "Arrival",
        .attributions = "Attributions",
        .before_travel_steps = "BeforeTravelSteps",
        .booking_web_links = "BookingWebLinks",
        .departure = "Departure",
        .incidents = "Incidents",
        .intermediate_stops = "IntermediateStops",
        .next_departures = "NextDepartures",
        .notices = "Notices",
        .pass_through_waypoints = "PassThroughWaypoints",
        .spans = "Spans",
        .summary = "Summary",
        .transport = "Transport",
        .travel_steps = "TravelSteps",
    };
};
