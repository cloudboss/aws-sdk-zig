const RouteTransitPlace = @import("route_transit_place.zig").RouteTransitPlace;
const RouteTransitTripStatus = @import("route_transit_trip_status.zig").RouteTransitTripStatus;

/// Details corresponding to the arrival for the leg.
pub const RouteTransitArrival = struct {
    /// The delay from the scheduled arrival time.
    ///
    /// **Unit**: `seconds`
    delay: ?i64 = null,

    /// Place details corresponding to the arrival.
    place: RouteTransitPlace,

    /// The status of the arrival.
    status: ?RouteTransitTripStatus = null,

    /// The arrival time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .delay = "Delay",
        .place = "Place",
        .status = "Status",
        .time = "Time",
    };
};
