const RouteTransitTripStatus = @import("route_transit_trip_status.zig").RouteTransitTripStatus;
const RouteTransitTransportModeDetails = @import("route_transit_transport_mode_details.zig").RouteTransitTransportModeDetails;

/// Details about the next available departure for the transit service.
pub const RouteTransitNextDeparture = struct {
    /// The delay from the scheduled departure time.
    ///
    /// **Unit**: `seconds`
    delay: ?i64 = null,

    /// Platform name or number for the departure.
    platform_name: ?[]const u8 = null,

    /// The status of the departure.
    status: ?RouteTransitTripStatus = null,

    /// The departure time.
    time: []const u8,

    /// Transport mode details for this departure.
    transport: ?RouteTransitTransportModeDetails = null,

    pub const json_field_names = .{
        .delay = "Delay",
        .platform_name = "PlatformName",
        .status = "Status",
        .time = "Time",
        .transport = "Transport",
    };
};
