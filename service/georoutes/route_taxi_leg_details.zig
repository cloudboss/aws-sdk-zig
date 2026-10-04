const RouteTaxiAfterTravelStep = @import("route_taxi_after_travel_step.zig").RouteTaxiAfterTravelStep;
const RouteTaxiAgency = @import("route_taxi_agency.zig").RouteTaxiAgency;
const RouteTaxiArrival = @import("route_taxi_arrival.zig").RouteTaxiArrival;
const RouteAttribution = @import("route_attribution.zig").RouteAttribution;
const RouteTaxiBeforeTravelStep = @import("route_taxi_before_travel_step.zig").RouteTaxiBeforeTravelStep;
const RouteWebLink = @import("route_web_link.zig").RouteWebLink;
const RouteTaxiDeparture = @import("route_taxi_departure.zig").RouteTaxiDeparture;
const RouteTaxiNotice = @import("route_taxi_notice.zig").RouteTaxiNotice;
const RouteTaxiSummary = @import("route_taxi_summary.zig").RouteTaxiSummary;
const RouteTaxiTransportModeDetails = @import("route_taxi_transport_mode_details.zig").RouteTaxiTransportModeDetails;
const RouteTaxiTravelStep = @import("route_taxi_travel_step.zig").RouteTaxiTravelStep;

/// Populated when the Leg type is Taxi, and provides additional information
/// that is specific to taxi travel.
pub const RouteTaxiLegDetails = struct {
    /// Steps of a leg that must be performed after the travel portion of the leg.
    after_travel_steps: []const RouteTaxiAfterTravelStep,

    /// Details about the taxi agency.
    agency: RouteTaxiAgency,

    /// Details corresponding to the arrival for the leg.
    arrival: RouteTaxiArrival,

    /// List of required attributions to display.
    attributions: []const RouteAttribution,

    /// Steps of a leg that must be performed before the travel portion of the leg.
    before_travel_steps: []const RouteTaxiBeforeTravelStep,

    /// Web links to external ticket booking services for the taxi.
    booking_web_links: []const RouteWebLink,

    /// Details corresponding to the departure for the leg.
    departure: RouteTaxiDeparture,

    /// List of notices that indicate issues that occurred during route calculation.
    notices: []const RouteTaxiNotice,

    /// Summary of the taxi leg.
    summary: ?RouteTaxiSummary = null,

    /// Transport mode details for the taxi leg.
    transport: RouteTaxiTransportModeDetails,

    /// Steps of a leg that must be performed during the travel portion of the leg.
    travel_steps: []const RouteTaxiTravelStep,

    pub const json_field_names = .{
        .after_travel_steps = "AfterTravelSteps",
        .agency = "Agency",
        .arrival = "Arrival",
        .attributions = "Attributions",
        .before_travel_steps = "BeforeTravelSteps",
        .booking_web_links = "BookingWebLinks",
        .departure = "Departure",
        .notices = "Notices",
        .summary = "Summary",
        .transport = "Transport",
        .travel_steps = "TravelSteps",
    };
};
