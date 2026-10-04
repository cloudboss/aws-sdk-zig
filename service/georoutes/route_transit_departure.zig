const RouteTransitPlace = @import("route_transit_place.zig").RouteTransitPlace;
const RouteTransitTripStatus = @import("route_transit_trip_status.zig").RouteTransitTripStatus;

/// Details corresponding to the departure for the leg.
pub const RouteTransitDeparture = struct {
    /// The delay from the scheduled departure time.
    ///
    /// **Unit**: `seconds`
    delay: ?i64 = null,

    /// Place details corresponding to the departure.
    place: RouteTransitPlace,

    /// The status of the departure.
    status: ?RouteTransitTripStatus = null,

    /// The departure time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .delay = "Delay",
        .place = "Place",
        .status = "Status",
        .time = "Time",
    };
};
