const RouteTransitIntermediateStopAttribute = @import("route_transit_intermediate_stop_attribute.zig").RouteTransitIntermediateStopAttribute;
const RouteTransitDeparture = @import("route_transit_departure.zig").RouteTransitDeparture;
const RouteTransitTransportModeDetails = @import("route_transit_transport_mode_details.zig").RouteTransitTransportModeDetails;

/// An intermediate stop between departure and destination of the transit route.
pub const RouteTransitIntermediateStop = struct {
    /// Attributes of the intermediate stop.
    attributes: ?[]const RouteTransitIntermediateStopAttribute = null,

    /// Departure details for the intermediate stop.
    departure: RouteTransitDeparture,

    /// Duration of the stop.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    /// Offset in the leg geometry corresponding to the start of this stop.
    geometry_offset: ?i32 = null,

    /// Transport mode details at the intermediate stop.
    transport: ?RouteTransitTransportModeDetails = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .departure = "Departure",
        .duration = "Duration",
        .geometry_offset = "GeometryOffset",
        .transport = "Transport",
    };
};
