const RouteRentalPlace = @import("route_rental_place.zig").RouteRentalPlace;

/// Details corresponding to the arrival for the leg.
pub const RouteRentalArrival = struct {
    /// Place details corresponding to the arrival.
    place: RouteRentalPlace,

    /// The arrival time.
    time: ?[]const u8 = null,

    pub const json_field_names = .{
        .place = "Place",
        .time = "Time",
    };
};
