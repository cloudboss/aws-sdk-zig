const RouteRentalAfterTravelStep = @import("route_rental_after_travel_step.zig").RouteRentalAfterTravelStep;
const RouteRentalAgency = @import("route_rental_agency.zig").RouteRentalAgency;
const RouteRentalArrival = @import("route_rental_arrival.zig").RouteRentalArrival;
const RouteAttribution = @import("route_attribution.zig").RouteAttribution;
const RouteRentalBeforeTravelStep = @import("route_rental_before_travel_step.zig").RouteRentalBeforeTravelStep;
const RouteWebLink = @import("route_web_link.zig").RouteWebLink;
const RouteRentalDeparture = @import("route_rental_departure.zig").RouteRentalDeparture;
const RouteRentalSummary = @import("route_rental_summary.zig").RouteRentalSummary;
const RouteRentalTransportModeDetails = @import("route_rental_transport_mode_details.zig").RouteRentalTransportModeDetails;
const RouteRentalTravelStep = @import("route_rental_travel_step.zig").RouteRentalTravelStep;

/// Populated when the Leg type is Rental, and provides additional information
/// that is specific to rental vehicle travel.
pub const RouteRentalLegDetails = struct {
    /// Steps of a leg that must be performed after the travel portion of the leg.
    after_travel_steps: []const RouteRentalAfterTravelStep,

    /// Details about the rental agency.
    agency: RouteRentalAgency,

    /// Details corresponding to the arrival for the leg.
    arrival: RouteRentalArrival,

    /// List of required attributions to display.
    attributions: []const RouteAttribution,

    /// Steps of a leg that must be performed before the travel portion of the leg.
    before_travel_steps: []const RouteRentalBeforeTravelStep,

    /// Web links to external ticket booking services for the rental.
    booking_web_links: []const RouteWebLink,

    /// Details corresponding to the departure for the leg.
    departure: RouteRentalDeparture,

    /// Summary of the rental leg.
    summary: ?RouteRentalSummary = null,

    /// Transport mode details for the rental leg.
    transport: RouteRentalTransportModeDetails,

    /// Steps of a leg that must be performed during the travel portion of the leg.
    travel_steps: []const RouteRentalTravelStep,

    pub const json_field_names = .{
        .after_travel_steps = "AfterTravelSteps",
        .agency = "Agency",
        .arrival = "Arrival",
        .attributions = "Attributions",
        .before_travel_steps = "BeforeTravelSteps",
        .booking_web_links = "BookingWebLinks",
        .departure = "Departure",
        .summary = "Summary",
        .transport = "Transport",
        .travel_steps = "TravelSteps",
    };
};
